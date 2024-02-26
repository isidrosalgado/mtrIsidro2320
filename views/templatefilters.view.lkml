view: templatefilters {
  dimension: my_date {
    type: date
    sql: ${TABLE}.date ;;
  }

  filter: my_template_filter {
    type: date
    description: "Template Filter for Date Range"
  }

  measure: period_weeks {
    type: number
    sql: ${user_my_template_filter.end_date} - ${user_my_template_filter.start_date} ;;
  }

  measure: start_date {
    type: date
    sql: CASE WHEN ${period_weeks} < 25 THEN DATE_ADD(${user_my_template_filter.end_date}, INTERVAL -25 WEEK)
              ELSE ${user_my_template_filter.start_date}
         END ;;
  }
  }
