db.lecture.find({attendance_records: {$elemMatch: {is_attending: true}}})

db.users.find({awards: {$elemMatch: {award:'National Medal', year:1975}}})


function getLectureParticipationRate(lecture_id) {
    const amountOfParticipators =


    const lectureParticipationRate =
}