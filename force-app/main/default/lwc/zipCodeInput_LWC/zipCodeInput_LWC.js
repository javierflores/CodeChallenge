import { LightningElement, track, wire } from 'lwc';
import getZipCodeData from '@salesforce/apex/ZipCodeController.getZipCodeData';
import saveNonUSZipCodeData from '@salesforce/apex/ZipCodeController.saveNonUSZipCodeData';

export default class ZipCodeData extends LightningElement {
    country = 'US'; //default for testing
    zipCode = '90210'; //default for testing
    zipCodeInfo;
    @track usZipCodes = [];
    error;

    handleCountryChange(event) {
        this.country = event.target.value;
    }

    handleZipChange(event) {
        this.zipCode = event.target.value;
    }

    search() {
        getZipCodeData({ pCountry: this.country, pZipCode: this.zipCode })
            .then(result => {
                this.zipCodeInfo = result;
                this.error = undefined;

                const obj = {
                    post_Code: this.zipCodeInfo.post_Code,
                    country: this.zipCodeInfo.country,
                    country_abbreviation: this.zipCodeInfo.country_abbreviation
                }

                if(result.country_abbreviation !== 'US') {
                    saveNonUSZipCodeData({ jsonString: JSON.stringify(obj) })
                        .then(saveResult => {
                            console.log(saveResult);
                        })
                        .catch(saveError => {
                            this.error = saveError.body.message;
                        });
                }else{
                    this.usZipCodes.push(this.zipCodeInfo);
                }
            })
            .catch(error => {
                this.error = error.body.message;
                this.zipCodeInfo = undefined;
            });
    }

    clearError() {
        this.error = null;
    }
}
