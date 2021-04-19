/* 
 * Author: Caleb Beck
 * 
 * Please note that the indices of the columns where the names and total
 * balances occur in the spread sheet are hard coded in. If these fields
 * are moved to different columns, nameCol and balanceCol must be updated!
 */

const google = require('@googleapis/sheets')

// Column of the sheet containing names
const nameCol = 0;
// Column of the sheet containing balances
const balanceCol = 10;

// Found on the Google Sheet URL
const spreadsheetId = "1qSM8TkQIrX0aRROCMwg9WOupm68h6M66DrKVV6uCrCA";
// Found at the bottom of the Google Sheet. Set as "Sheet1" by default.
const sheetName = "Sheet1";
// Remove ".readonly" to allow edits to the sheet
const SCOPES = ['https://www.googleapis.com/auth/spreadsheets.readonly'];

const sheets = google.sheets('v4');

// Get authorization token needed to access the spread sheet
async function getAuthToken() {
    // Project ID
    process.env.GCLOUD_PROJECT = "rootedwi-310514";
    // Path to the JSON key
    process.env.GOOGLE_APPLICATION_CREDENTIALS = "./rootedwi-310514-16d4c451156d.json";

    const auth = new google.auth.GoogleAuth({
      scopes: SCOPES
    });

    const authToken = await auth.getClient();
    return authToken;
}

// Get all values in sheetName 
async function getSheetValues({auth}) {
    const sheetVals = await sheets.spreadsheets.values.get({
        spreadsheetId,
        auth,
        range: sheetName
    });

    return sheetVals;
}

// Get balance associated with name
function getBalance(response, name) {
    name = name.normalize();

    for (let i = 0; i < response.data.values.length; ++i) {
        if (response.data.values[i][nameCol].normalize() === name)
            return parseInt(response.data.values[i][balanceCol]);
    }

    return null;
}

/**
 * Finds the balance associated with a name. May throw an error if Google
 * doesn't authorize connection to the spreadsheet or it can't be found.
 * 
 * @param {string} name A name (case sensitive) in the balance sheet
 * @returns {number} The current balance of "name" or null if name isn't found
 */
const getAllData = async (name) => {
    if (name === "" || typeof name !== 'string')
        return null;

    const auth = await getAuthToken();
    const response = await getSheetValues({auth});
    return getBalance(response, name);
};
  
module.exports = getAllData;
