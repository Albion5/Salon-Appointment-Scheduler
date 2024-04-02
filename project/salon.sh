#! /bin/bash

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~~~~~ My Salon ~~~~~\n"

FIND_SERVICE() {
    echo $($PSQL "SELECT name FROM services WHERE service_id = $1")
}

FIND_CUSTOMER() {
    echo $($PSQL "SELECT name FROM customers WHERE phone = '$1'")#! /bin/bash

PSQL="psql -X --username=allie --dbname=salon --tuples-only -c"

echo -e "\n~~~~~ My Salon ~~~~~\n"

FIND_SERVICE() {
    echo $($PSQL "SELECT name FROM services WHERE service_id = $1")
}

FIND_CUSTOMER() {
    echo $($PSQL "SELECT name FROM customers WHERE phone = '$1'")
}

ADD_CUSTOMER() {
    echo $($PSQL "INSERT INTO customers(name, phone) VALUES('$1', '$2')")
}

ADD_APPOINTMENT() {
    local CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$1'")
    echo $($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $2, '$3')")
}

MAIN_MENU() {
    if [[ "$1" ]]
    then
        echo -e "\n$1"
    fi

    SERVICES=$($PSQL "SELECT service_id, name FROM SERVICES") 
    echo "$SERVICES" | while read SERVICE_ID BAR SERVICE_NAME
    do
        echo "$SERVICE_ID) $SERVICE_NAME"
    done
    
    read SERVICE_ID_SELECTED
    if [[ $SERVICE_ID_SELECTED =~ ^[0-9]+$ ]]
    then
        SERVICE_NAME=$(FIND_SERVICE $SERVICE_ID_SELECTED)
        if [[ -z $SERVICE_NAME ]]
        then
            MAIN_MENU "I could not find that service. What would you like today?"
        else
            echo -e "\nWhat's your phone number?"
            read CUSTOMER_PHONE
            CUSTOMER_NAME=$(FIND_CUSTOMER $CUSTOMER_PHONE)
            if [[ -z $CUSTOMER_NAME ]]
            then
                echo -e "\nI don't have a record for that phone number, what's your name?"
                read CUSTOMER_NAME
               INSERT_CUSTOMER_RESULT=$(ADD_CUSTOMER "$CUSTOMER_NAME" "$CUSTOMER_PHONE")
            fi
            echo -e "\nWhat time would you like your $SERVICE_NAME, $CUSTOMER_NAME?"
            read SERVICE_TIME
            INSERT_APPOINTMENT_RESULT=$(ADD_APPOINTMENT $CUSTOMER_PHONE $SERVICE_ID_SELECTED "$SERVICE_TIME")
            echo -e "I have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
        fi
    else
        MAIN_MENU "That is not a valid service number."
    fi

}

MAIN_MENU "Welcome to My Salon, how can I help you?\n"

}

ADD_CUSTOMER() {
    echo $($PSQL "INSERT INTO customers(name, phone) VALUES('$1', '$2')")
}

ADD_APPOINTMENT() {
    local CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$1'")
    echo $($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $2, '$3')")
}

MAIN_MENU() {
    if [[ "$1" ]]
    then
        echo -e "\n$1"
    fi

    SERVICES=$($PSQL "SELECT service_id, name FROM SERVICES") 
    echo "$SERVICES" | while read SERVICE_ID BAR SERVICE_NAME
    do
        echo "$SERVICE_ID) $SERVICE_NAME"
    done
    
    read SERVICE_ID_SELECTED
    if [[ $SERVICE_ID_SELECTED =~ ^[0-9]+$ ]]
    then
        SERVICE_NAME=$(FIND_SERVICE $SERVICE_ID_SELECTED)
        if [[ -z $SERVICE_NAME ]]
        then
            MAIN_MENU "I could not find that service. What would you like today?"
        else
            echo -e "\nWhat's your phone number?"
            read CUSTOMER_PHONE
            CUSTOMER_NAME=$(FIND_CUSTOMER $CUSTOMER_PHONE)
            if [[ -z $CUSTOMER_NAME ]]
            then
                echo -e "\nI don't have a record for that phone number, what's your name?"
                read CUSTOMER_NAME
               INSERT_CUSTOMER_RESULT=$(ADD_CUSTOMER "$CUSTOMER_NAME" "$CUSTOMER_PHONE")
            fi
            echo -e "\nWhat time would you like your $SERVICE_NAME, $CUSTOMER_NAME?"
            read SERVICE_TIME
            INSERT_APPOINTMENT_RESULT=$(ADD_APPOINTMENT $CUSTOMER_PHONE $SERVICE_ID_SELECTED "$SERVICE_TIME")
            echo -e "I have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
        fi
    else
        MAIN_MENU "That is not a valid service number."
    fi

}

MAIN_MENU "Welcome to My Salon, how can I help you?\n"
