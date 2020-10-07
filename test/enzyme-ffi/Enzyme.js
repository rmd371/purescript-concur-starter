const enzyme = require('enzyme');
const Adapter = require('enzyme-adapter-react-16');

const {configure, shallow} = enzyme;

configure({adapter: new Adapter()});

exports.shallow = reactElm => () => shallow(reactElm);
exports.text = selector => wrapper => wrapper.find(selector).text();
exports.text_ = wrapper => wrapper.text();

exports._clickElm = selector => event => wrapper => {
    return async function() {
        await wrapper.find(selector).prop('onClick')(event);
    }
}

exports._clickElm2 = () => selector => event => wrapper => {
    return async function() {
        await wrapper.find(selector).prop('onClick')(event);
    }
}

exports.consoleLog = (x) => () => { 
    console.log(x); 
    return x; 
}
