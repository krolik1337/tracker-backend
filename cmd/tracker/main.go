package main

import (
	"example/tracker/app"
	"fmt"
	"net/http"
	"os"

	"github.com/gorilla/mux"
	"gorm.io/driver/postgres"
	"gorm.io/gorm"
)

const (
	host     = "localhost"
	port     = 5432
	username = "postgres"
	dbname   = "trackerDB"
)

var password string = os.Getenv("PSQL_PASSWORD")
var appport string = os.Getenv("PORT")
var DB *gorm.DB

func main() {
	connectDB()
	router := mux.NewRouter()
	repo := app.NewPostgresRepository(DB)
	//specify handler for endpoints, initiate server
	router.Handle("/track/pixel.gif", app.TrackerHandler(repo)).Methods("GET")
	router.Handle("/stats", app.StatsHandler(repo)).Methods("GET")
	router.Handle("/test", app.TestHandler()).Methods("GET")
	router.Handle("/another-test", app.TestHandler()).Methods("GET")
	http.ListenAndServe(":"+appport, router)
}

func connectDB() {
	dsn := fmt.Sprintf("host=%s user=%s password=%s dbname=%s port=%d", host, username, password, dbname, port)
	db, err := gorm.Open(postgres.Open(dsn), &gorm.Config{})
	if err != nil {
		panic(err)
	}
	DB = db
}
