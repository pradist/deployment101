package main

import (
	"fmt"
	"net/http"
	"os"

	"github.com/gin-gonic/gin"
	"gorm.io/driver/postgres"
	"gorm.io/gorm"
)

func main() {
	r := gin.Default()

	// ดึงค่าจาก Environment Variables ที่เราจะตั้งใน k8s
	dsn := fmt.Sprintf("host=%s user=%s password=%s dbname=%s port=%s sslmode=disable",
		os.Getenv("DB_HOST"),
		os.Getenv("DB_USER"),
		os.Getenv("DB_PASSWORD"),
		os.Getenv("DB_NAME"),
		os.Getenv("DB_PORT"),
	)

	db, err := gorm.Open(postgres.Open(dsn), &gorm.Config{})

	r.GET("/health", func(c *gin.Context) {
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"status": "Database Connection Error", "error": err.Error()})
			return
		}
		c.JSON(http.StatusOK, gin.H{"status": "UP", "message": "Connected to Postgres!"})
	})

	r.Run(":8080")
}
