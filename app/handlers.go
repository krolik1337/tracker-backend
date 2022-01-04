package app

import (
	"encoding/json"
	"errors"
	"fmt"
	"net"
	"net/http"
	"text/template"

	"github.com/google/uuid"
	"github.com/mssola/user_agent"
	"golang.org/x/text/language"
)

const pixel = "\x47\x49\x46\x38\x39\x61\x01\x00\x01\x00\x80\x00\x00\x00\x00\x00\x00\x00\x00\x21\xF9\x04\x01\x00\x00\x00\x00\x2C\x00\x00\x00\x00\x01\x00\x01\x00\x00\x02\x02\x44\x01\x00\x3B"

func setCookie(e *Log, w http.ResponseWriter, r *http.Request) {
	siteCookies := r.Cookies()
	var isCookieSet bool
	//check if the cookie is set, if it is - get log UUID
	for _, c := range siteCookies {
		if c.Name == "TrackerUserID" {
			isCookieSet = true
			e.UUID = c.Value
		}
	}
	//create and set the cookie if there is none
	if !isCookieSet {
		e.UUID = uuid.New().String()
		cookie := http.Cookie{
			Name:     "TrackerUserID",
			Value:    e.UUID,
			MaxAge:   3600,
			Secure:   true,
			SameSite: http.SameSiteLaxMode,
		}
		http.SetCookie(w, &cookie)
	}
}

func parseLanguage(l string) string {
	languages, _, err := language.ParseAcceptLanguage(l) //get browser language
	if err != nil {
		panic(err)
	}
	lang, _ := languages[0].Base()
	return lang.String()
}

func parseIP(s string) string {
	ip, _, err := net.SplitHostPort(s)
	if err != nil {
		panic(err)
	}
	return net.ParseIP(ip).String()
}

func fillData(e *Log, s string, r *http.Request) error {
	if s != "" {
		ua := user_agent.New(s)                    //create instance of User Agnet parser and pass log agent to it
		e.VisitedPage = r.Header.Get("Referer")    //get URL from which pixel was accessed
		e.Browser, e.BrowserVersion = ua.Browser() //get browser name and version
		e.Language = parseLanguage(r.Header.Get("Accept-Language"))
		e.OS = ua.OSInfo().FullName //get OS name and version
		e.UserAgent = ua.UA()       // get raw log-agent string
		e.IP = parseIP(r.RemoteAddr)
		if ua.Mobile() {
			e.Device = "mobile"
		} else {
			e.Device = "desktop"
		} //check if log uses mobile
		fmt.Println(*e)
		return nil
	} else {
		return errors.New("user-agent string is empty")
	}
}

func TrackerHandler(repo Repository) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		var log Log
		setCookie(&log, w, r)
		//gather log data
		rawua := r.Header.Get("User-Agent")
		err := fillData(&log, rawua, r)
		if err != nil {
			panic(err)
		}
		repo.Save(&log)
		//place pixel in response header and return it
		w.WriteHeader(http.StatusOK)
		w.Header().Set("Content-Type", "image/gif")
		// w.Write(fileBytes)
		fmt.Fprintf(w, pixel)
	})
}

func StatsHandler(repo Repository) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		entries, err := repo.Fetch()
		if err != nil {
			panic(err)
		}
		languages, err := repo.GetCount("language")
		if err != nil {
			panic(err)
		}
		pages, err := repo.GetCount("visited_page")
		if err != nil {
			panic(err)
		}
		devices, err := repo.GetCount("device")
		if err != nil {
			panic(err)
		}
		oss, err := repo.GetCount("os")
		if err != nil {
			panic(err)
		}
		browsers, err := repo.GetCount("browser")
		if err != nil {
			panic(err)
		}
		ips, err := repo.GetCount("ip")
		if err != nil {
			panic(err)
		}
		traffic, err := repo.GetTraffic()
		if err != nil {
			panic(err)
		}
		stats := map[string]interface{}{"ips": ips, "languages": languages, "pages": pages, "devices": devices, "traffic": traffic, "oss": oss, "browsers": browsers, "raw_data": entries}
		jsonResponse, _ := json.Marshal(stats)
		w.Header().Set("Access-Control-Allow-Origin", "*")
		w.Header().Set("Content-Type", "application/json")
		fmt.Fprint(w, string(jsonResponse))
	})
}

func TestHandler() http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		t, err := template.ParseFiles("test.html")
		if err != nil {
			fmt.Println(err)
		}
		t.Execute(w, nil)
	})
}
