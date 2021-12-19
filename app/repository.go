package app

import "gorm.io/gorm"

type psqlRepo struct {
	db *gorm.DB
}

func NewPostgresRepository(db *gorm.DB) Repository {
	return &psqlRepo{db: db}
}

func (pr *psqlRepo) Save(entry *Log) error {
	return pr.db.Create(&entry).Error
}
func (pr *psqlRepo) Fetch() ([]*Log, error) {
	var logs []*Log
	result := pr.db.Find(&logs)
	if result.Error != nil {
		return nil, result.Error
	} else {
		return logs, nil
	}
}
func (pr *psqlRepo) GetCount(c string) ([]*ColumnCount, error) {
	var cc []*ColumnCount
	result := pr.db.Table("logs").Select(c+" as name, count(?::text) as count", c).Group(c).Find(&cc)
	if result.Error != nil {
		return nil, result.Error
	} else {
		return cc, nil
	}
}

func (pr *psqlRepo) GetTraffic() ([]int, error) {
	var t []*Traffic
	tl := make([]int, 24)
	result := pr.db.Table("logs").Select("date_part('hour', created_at) as hour, count(created_at) as visits").Group("hour").Order("hour asc").Find(&t)
	if result.Error != nil {
		return nil, result.Error
	}
	for _, v := range t {
		tl[v.Hour] = v.Visits
	}
	return tl, nil
}
