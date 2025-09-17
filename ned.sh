
#!/bin/bash

function ned() {
    # Define the JSON file paths in an array
    JSON_FILES=("/home/teodor/dev/erp8/src/locales/nl.json" "/home/teodor/dev/erp8/src/locales/de.json" "/home/teodor/dev/erp8/src/locales/en.json")

    # Loop through the array and for each file
    for JSON_FILE in "${JSON_FILES[@]}"
    do
            # Define the new key value pair to add
            NEW_KEY="$1"
            NEW_VALUE="\"\""

            # Add the new key value pair to the JSON object
            jq --arg new_key "$NEW_KEY" --arg new_value "$NEW_VALUE" '. + {($new_key): $new_value}' "$JSON_FILE" > tmp.json && mv tmp.json "$JSON_FILE"

            # Sort the keys of the JSON object alphabetically
            jq -S '.' "$JSON_FILE" > tmp.json && mv tmp.json "$JSON_FILE"
    done
}
