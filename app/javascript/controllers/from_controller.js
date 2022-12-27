import {Controller} from '@hotwired/stimulus'

export default class extends Controller {

    static targets = [
        'input',
        'city'
    ]

    connect() {
        console.log("From controller is connected");
        
    }


    initGoogle(){
        console.log(`Google maps is initialized and the address controller knows about it`)
        console.log(google)
        this.autocomplete = new google.maps.places.Autocomplete(this.inputTarget, {
            fields: ["address_components", "geometry"],
            types: ["address"]
        })

        this.autocomplete.addListener('place_changed', this.placeSelected.bind(this))
    }

    placeSelected() {
        const place = this.autocomplete.getPlace();
        console.log(place);


        for (const component of place.address_components) {
            // @ts-ignore remove once typings fixed
            const componentType = component.types[0];
        
            switch (componentType) {
              
              case "locality":
                this.cityTarget.value = component.long_name;
                break;

              
            }
          }






    }

}