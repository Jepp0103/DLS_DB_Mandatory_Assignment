function getLectureParticipationRate(lecture_id) {
    const lectureParticipationRate = (db.lecture.aggregate([
        {
            $match : {_id : lecture_id}
        },
        {
            $project: {
                _id : 0,
                lectureParticipationRate: {
                    $multiply: [
                        { $divide: [
                                { $cond: {
                                        if: {$isArray: "$attendance_records"}, then:
                                            {
                                                $size: //Amount of participators
                                                    {
                                                        $filter: {
                                                            input: "$attendance_records",
                                                            as: "att_records",
                                                            cond: {$eq: ["$$att_records.is_attending", true]}
                                                        }
                                                    }
                                            },
                                        else: "NA"
                                    }
                                }, //Separator between the two values to divide
                                { $cond: {
                                        if: {$isArray: "$attendance_records"}, then:
                                            {$size: "$attendance_records"}, //Amount of total attendances
                                        else: "NA"
                                    }
                                }
                            ]
                        },
                        100 //Times 100 to convert into percent
                    ]
                }
            },
        }
    ] ));
    return lectureParticipationRate;
}

getLectureParticipationRate(1);