package app

import "time"

type Log struct {
	Id             int       `json:"id"`
	UUID           string    `json:"uuid"`
	VisitedPage    string    `json:"page"`
	Browser        string    `json:"browser"`
	BrowserVersion string    `json:"browserv"`
	Language       string    `json:"lang"`
	OS             string    `json:"os"`
	IP             string    `json:"ip"`
	Device         string    `json:"device"`
	UserAgent      string    `json:"ua"`
	CreatedAt      time.Time `json:"created_at"`
}

type ColumnCount struct {
	Name  string `json:"name"`
	Count int    `json:"count"`
}

type Traffic struct {
	Hour   int `json:"hour"`
	Visits int `json:"visits"`
}
type Repository interface {
	Save(entry *Log) error
	Fetch() ([]*Log, error)
	GetCount(s string) ([]*ColumnCount, error)
	GetTraffic() ([]int, error)
}
