//If db exists and is selected and needs to be dropped
db.dropDatabase()
use
roll_call_mongo_db


//Dropping tables
db.student.drop()
db.lecture.drop()
db.teacher.drop()


//Create new table (collection)
db.createCollection('student')
db.createCollection('lecture')
db.createCollection('teacher')

//Query all collections
db.student.insertMany([
    {
        _id: 1,
        forename: 'Lars',
        surname: 'Larsen',
        email_address: 'lars@mail.com',
        phone_number: '12345678',
        gps_coordinates: {
            longitude: '55.70392118',
            latitude: '12.537521047'
        },
        network: {
            ssid: 'KEANET',
            ip_address: '193.29.107.196',
            faculty: 'KEA - Københavns Erhvervsakademi'
        },
        classes: {
            name: 'SD21w1',
            faculty: 'KEA - Københavns Erhvervsakademi'
        }
    },
    {
        _id: 2,
        forename: 'Carl',
        surname: 'Carlsen',
        email_address: 'carl@mail.com',
        phone_number: '87654321',
        gps_coordinates: {
            longitude: '55.70392118',
            latitude: '12.537521047'
        },
        network: {
            ssid: 'KEANET',
            ip_address: '193.29.107.196',
            faculty: 'KEA - Københavns Erhvervsakademi'
        },
        classes: {
            name: 'SD21w2',
            faculty: 'KEA - Københavns Erhvervsakademi'
        }
    },
    {
        _id: 3,
        forename: 'Mads',
        surname: 'Madsen',
        email_address: 'mads@mail.com',
        phone_number: '29292929',
        gps_coordinates: {
            longitude: '60.70392118',
            latitude: '20.537521047'
        },
        network: {
            ssid: 'DTU NET',
            ip_address: '193.29.109.198',
            faculty: 'DTU - Danmarks Tekniske Universitet'
        },
        classes: {
            name: 'DTU_Class_2',
            faculty: 'DTU - Danmarks Tekniske Universitet'
        }
    },
    {
        _id: 4,
        forename: 'Georg',
        surname: 'Jensen',
        email_address: 'georg@mail.com',
        phone_number: '12121212',
        gps_coordinates: {
            longitude: '60.70392118',
            latitude: '20.537521047'
        },
        network: {
            ssid: 'DTU NET',
            ip_address: '193.29.109.198',
            faculty: 'DTU - Danmarks Tekniske Universitet'
        },
        classes: {
            name: 'DTU_Class_2',
            faculty: 'DTU - Danmarks Tekniske Universitet'
        }
    },
    {
        _id: 5,
        forename: 'Poul',
        surname: 'Poulsen',
        email_address: 'poul@mail.com',
        phone_number: '13131313',
        gps_coordinates: {
            longitude: '65.70392118',
            latitude: '16.537521047'
        },
        network: {
            ssid: 'CBS NET',
            ip_address: '193.29.107.199',
            faculty: 'CBS - Copenhagen Business School'
        },
        classes: {
            name: 'CBS_Class_1',
            faculty: 'CBS - Copenhagen Business School'
        }
    },
    {
        _id: 6,
        forename: 'Jason',
        surname: 'Derulo',
        email_address: 'jason@mail.com',
        phone_number: '23232323',
        gps_coordinates: {
            longitude: '65.70392118',
            latitude: '16.537521047'
        },
        network: {
            ssid: 'CBS NET',
            ip_address: '193.29.107.199',
            faculty: 'CBS - Copenhagen Business School'
        },
        classes: {
            name: 'CBS_Class_1',
            faculty: 'CBS - Copenhagen Business School'
        }
    },
    {
        _id: 7,
        forename: 'Fred',
        surname: 'Jensen',
        email_address: 'fred@mail.com',
        phone_number: '15151515',
        gps_coordinates: {
            longitude: '65.70392118',
            latitude: '16.537521047'
        },
        network: {
            ssid: 'CBS NET',
            ip_address: '193.29.107.199',
            faculty: 'CBS - Copenhagen Business School'
        },
        classes: {
            name: 'CBS_Class_1',
            faculty: 'CBS - Copenhagen Business School'
        }
    },
    {
        _id: 8,
        forename: 'Soul',
        surname: 'Soulsen',
        email_address: 'soul@mail.com',
        phone_number: '14141414',
        gps_coordinates: {
            longitude: '65.70392118',
            latitude: '16.537521047'
        },
        network: {
            ssid: 'CBS NET',
            ip_address: '193.29.107.199',
            faculty: 'CBS - Copenhagen Business School'
        },
        classes: {
            name: 'CBS_Class_2',
            faculty: 'CBS - Copenhagen Business School'
        }
    },
    {
        _id: 9,
        forename: 'Mason',
        surname: 'Derulo',
        email_address: 'mason@mail.com',
        phone_number: '25252525',
        gps_coordinates: {
            longitude: '70.70392118',
            latitude: '20.537521047'
        },
        network: {
            ssid: 'KU NET',
            ip_address: '193.29.107.197',
            faculty: 'KU - Københavns Universitet'
        },
        classes: {
            name: 'KU_Class_1',
            faculty: 'KU - Københavns Universitet'
        }
    }
])

//Lectures
db.lecture.insertMany([
    {
        _id: 1,
        name: 'DB Lecture 1',
        date: '2021-03-15 08:15:00',
        time_start: '08:15:00',
        time_end: '13:30:00',
        time_zone: 0,
        length: 0,
        code: "abcde",
        course: {
            name: 'Databases for developers',
            ects: 10
        },
        classroom: {
            campus: {
                address: {
                    street_name: 'Lygten',
                    street_number: 37,
                    registred_on: '2021-02-23 20:02:21.550',
                    additional_details: 'Awesome campus',
                    city: {
                        zip_code: 2200,
                        city: "Copenhagen N"
                    }
                },
                faculty: 'KEA - Københavns Erhvervsakademi'
            },
            name: 'B234',
            is_available: false
        },
        classes: {
            name: 'SD21w2',
            faculty: 'KEA - Københavns Erhvervsakademi'
        },
        attendance_records: [
            {
                student: db.student.findOne({_id: 1}),
                is_attending: true
            },
            {
                student: db.student.findOne({_id: 2}),
                is_attending: false
            },
            {
                student: db.student.findOne({_id: 3}),
                is_attending: true
            },
            {
                student: db.student.findOne({_id: 4}),
                is_attending: false
            },
            {
                student: db.student.findOne({_id: 5}),
                is_attending: true
            }
        ]
    },
    {
        _id: 2,
        name: 'DB Lecture 2',
        date: '2021-04-15 08:15:00',
        time_start: '08:15:00',
        time_end: '13:30:00',
        time_zone: 0,
        length: 0,
        code: 'asklll',
        course: {
            name: 'Databases for developers',
            ects: 10
        },
        classroom: {
            campus: {
                address: {
                    street_name: 'Lygten',
                    street_number: 37,
                    registred_on: '2021-02-23 20:02:21.550',
                    additional_details: "Awesome campus",
                    city: {
                        zip_code: 2200,
                        city: "Copenhagen N"
                    }
                },
                faculty: 'KEA - Københavns Erhvervsakademi'
            },
            name: 'B234',
            is_available: true
        },
        classes: {
            name: 'SD21w2',
            faculty: 'KEA - Københavns Erhvervsakademi'
        },
        attendance_records: [
            {
                student: db.student.findOne({_id: 1}),
                is_attending: false
            },
            {
                student: db.student.findOne({_id: 2}),
                is_attending: false
            },
            {
                student: db.student.findOne({_id: 3}),
                is_attending: true
            },
            {
                student: db.student.findOne({_id: 4}),
                is_attending: false
            },
            {
                student: db.student.findOne({_id: 5}),
                is_attending: true
            }
        ]
    },
    {
        _id: 3,
        name: 'DLS Lecture 1',
        date: '2021-05-15 08:15:00',
        time_start: '08:15:00',
        time_end: '13:30:00',
        time_zone: 0,
        length: 0,
        code: "wo0433",
        course: {
            name: 'Development of large systems',
            ects: 10
        },
        classroom: {
            campus: {
                address: {
                    street_name: 'Lygten',
                    street_number: 37,
                    registred_on: '2021-02-23 20:02:21.550',
                    additional_details: "Awesome campus",
                    city: {
                        zip_code: 2200,
                        city: "Copenhagen N"
                    }
                },
                faculty: 'KEA - Københavns Erhvervsakademi'
            },
            name: 'B234',
            is_available: true
        },
        classes: {
            name: 'SD21w1',
            faculty: 'KEA - Københavns Erhvervsakademi'
        },
        attendance_records: [
            {
                student: db.student.findOne({_id: 1}),
                is_attending: true
            },
            {
                student: db.student.findOne({_id: 2}),
                is_attending: false
            },
            {
                student: db.student.findOne({_id: 3}),
                is_attending: false
            },
            {
                student: db.student.findOne({_id: 4}),
                is_attending: false
            },
            {
                student: db.student.findOne({_id: 5}),
                is_attending: false
            }
        ]
    },
    {
        _id: 4,
        name: 'DLS Lecture 2',
        date: '2021-05-16 08:15:00',
        time_start: '08:15:00',
        time_end: '13:30:00',
        time_zone: 0,
        length: 0,
        code: "dsds4",
        course: {
            name: 'Development of large systems',
            ects: 10
        },
        classroom: {
            campus: {
                address: {
                    street_name: 'Lygten',
                    street_number: 37,
                    registred_on: '2021-02-23 20:02:21.550',
                    additional_details: "Awesome campus",
                    city: {
                        zip_code: 2200,
                        city: "Copenhagen N"
                    }
                },
                faculty: 'KEA - Københavns Erhvervsakademi'
            },
            name: 'B234',
            is_available: false
        },
        classes: {
            name: 'SD21w1',
            faculty: 'KEA - Københavns Erhvervsakademi'
        },
        attendance_records: [
            {
                student: db.student.findOne({_id: 1}),
                is_attending: true
            },
            {
                student: db.student.findOne({_id: 2}),
                is_attending: false
            },
            {
                student: db.student.findOne({_id: 3}),
                is_attending: true
            },
            {
                student: db.student.findOne({_id: 4}),
                is_attending: false
            },
            {
                student: db.student.findOne({_id: 5}),
                is_attending: false
            }
        ]
    },
    {
        _id: 5,
        name: 'Testing Lecture 1',
        date: '2021-05-16 08:15:00',
        time_start: '08:15:00',
        time_end: '13:30:00',
        time_zone: 0,
        length: 0,
        code: "wo0d33",
        course: {
            name: 'Testing',
            ects: 10
        },
        classroom: {
            campus: {
                address: {
                    street_name: 'Lygten',
                    street_number: 37,
                    registred_on: '2021-02-23 20:02:21.550',
                    additional_details: "Awesome campus",
                    city: {
                        zip_code: 2200,
                        city: "Copenhagen N"
                    }
                },
                faculty: 'KEA - Københavns Erhvervsakademi'
            },
            name: 'B234',
            is_available: true
        },
        classes: {
            name: 'SD21w1',
            faculty: 'KEA - Københavns Erhvervsakademi'
        }
    }
])

//Teachers
db.teacher.insertMany([
    {
        _id: 1,
        forename: 'Tomas',
        surname: 'Pesek',
        email_address: 'tomas@mail.com',
        phone_number: '30303030',
        gps_coordinates: {
            longitude: '50.70392118',
            latitude: '25.537521047'
        },
    },
    {
        _id: 2,
        forename: 'Andrea',
        surname: 'Corradini',
        email_address: 'andrea@mail.com',
        phone_number: '40404040',
        gps_coordinates: {
            longitude: '50.70392118',
            latitude: '25.537521047'
        },
    },
])


//Query all collections
db.student.find()
db.lecture.find()
db.teacher.find()

//Similar to where clause sql
db.student.find({'classes.name': 'CBS_Class_1'})

//Sort collection in acsending order
db.student.find().sort({forename: 1})

