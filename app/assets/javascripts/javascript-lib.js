/// extends String
// this function enables to replace {0}, {1}, etc. strings
// with adequate arguments passed to this function
String.prototype.format = function() {
	var stringToReturn = this.toString();
	for(var i = 0; i < arguments.length; i++) {
		var regex = new RegExp("\\{" + i + "\\}", "g");
		stringToReturn = stringToReturn.replace(regex, arguments[i]);
	}
	return stringToReturn;
};
/// end extends String object

/// extends Array object
Array.prototype.each = function(fnCallback) {
    var value = null;
    for (var elementIndex in this) {
        if (this.hasOwnProperty(elementIndex)) {
            value = fnCallback.apply(this[elementIndex], [elementIndex, value]);
        }
    }
    return (value) ? value : this;
};
Array.prototype.select = function(fnCallback) {
    var value = Array();
    for (var elementIndex in this) {
        if (this.hasOwnProperty(elementIndex)) {
            value.push(fnCallback.apply(this[elementIndex], [elementIndex]));
        }
    }
    return value;
};
Array.prototype.findFirst = function(fnCheckCallback, parameter) {
	for (var elementIndex in this) {
		if (this.hasOwnProperty(elementIndex) && fnCheckCallback.apply(this[elementIndex], [elementIndex, parameter])) {
			return this[elementIndex]; 
		}
	}
};
Array.prototype.unique = function() {
	var aryToReturn = Array();
	for (var i = 0; i < this.length; i++) {
		var val = this[i];
		if (undefined === aryToReturn.findFirst(function() {return this == val})) {
			aryToReturn.push(val);
		}
	}
	return aryToReturn;
};
Array.prototype.remove = function(mixValue) {
	if (arguments.length) {
		if (typeof mixValue === 'function') {
			for (var i = this.length - 1; i >= 0; i--) {
				if (mixValue.apply(this[i], [i])) {
					this.splice(i, 1);
				}
			}
		} else if (mixValue instanceof Array) {
			var that = this;
			for (var i = this.length - 1; i >= 0; i--) {
				if (mixValue.findFirst(function() {return this==that[i]})) {
					this.splice(i, 1);
				}
			}
		} else {
			for (var i = this.length - 1; i >= 0; i--) {
				if (this[i] === mixValue) {
					this.splice(i, 1);
				}
			}
		}
	}
	return this;
};
/// end extend Array object