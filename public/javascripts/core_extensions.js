// I like extending core libraries.
// Copyright (c) Paul Mucur 2008

String.prototype.succ = function() {
  if (this.isNumber()) {
    return Number(this) + 1;
  } else {
  	var alphabet = 'abcdefghijklmnopqrstuvwxyz';
  	var result = "";
  	for (var i = 0; i < this.length; i++) {
  	  if (alphabet.indexOf(this.charAt(i).toLowerCase()) != -1) {
    		if (this.charAt(i).isUpperCase()) {
    			result += alphabet.charAt(alphabet.toUpperCase().indexOf(this.charAt(i)) + 1).toUpperCase();
    		} else {
    			result += alphabet.charAt(alphabet.indexOf(this.charAt(i)) + 1);
    		}
  		} else {
  		  result += this.charAt(i);
  		}
  	}
  	return result;
  }
};

String.prototype.isUpperCase = function() {
	return this.toUpperCase() == this;
};

String.prototype.isNumber = function() {
  return Number(this) == this;
};