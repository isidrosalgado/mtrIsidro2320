view: orders {
  sql_table_name: demo_db.orders ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }
  dimension_group: created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.created_at ;;
  }
  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  dimension: test_rule_recommendation {

    sql:
    CASE
      WHEN ${user_id} = 21404 THEN 'accept'
      WHEN ${user_id} = 1073 THEN 'review'
      WHEN ${user_id} = 15397 THEN 'reject'
      ELSE "nothing"
    END ;;
    type: string
  }
  dimension: test_rule_recommendation_final {
    sql:
      {% if ${user_id} == 21404 %} "accept"
      {% elsif ${user_id} == 1073 %} "review"
      {% elsif ${user_id} == 15397 %} "reject"
      {% else %} null
      {% endif %} ;;
    type: string
  }


  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
  id,
  users.id,
  users.first_name,
  users.last_name,
  billion_orders.count,
  fakeorders.count,
  hundred_million_orders.count,
  hundred_million_orders_wide.count,
  order_items.count,
  order_items_vijaya.count,
  ten_million_orders.count
  ]
  }

}
