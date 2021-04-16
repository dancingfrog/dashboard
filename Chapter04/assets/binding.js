// custom.js
const boxxyBinding = new Shiny.OutputBinding();

boxxyBinding.constructor.prototype.find =
    function(scope) /*: HTMLCollection */ {
        console.log("scope: ", scope.length);

        if (!!scope && scope.length > 0) {
            try {
                return scope[0].getElementsByClassName('boxxy');
            } catch(e) {
                console.error(e)
            }
        }

        return document.body.getElementsByClassName('boxxy');
        // return $(scope).find(".boxxy");
    };

boxxyBinding.constructor.prototype.getId =
    function(el) {
        return el['data-input-id'] || el.id;
    };

boxxyBinding.constructor.prototype.renderValue =
    function(el, data) {
        console.log('el: ', el);
        console.log('data: ', data);

        // insert the title
        let header_id = el.id + '-boxxy-title';
        document.getElementById(header_id).innerText = data.title;

        // place counter in elementId
        // start at 0 and count up to 123
        let counter_id = el.id + '-boxxy-counter';
        const counter = new CountUp(counter_id, 0, data.value);
        counter.start();

        // background color
        el.style.backgroundColor = data.color;
    };

console.log(Object.create({}, boxxyBinding));

// register
Shiny.outputBindings.register(boxxyBinding, "john.boxxy");
