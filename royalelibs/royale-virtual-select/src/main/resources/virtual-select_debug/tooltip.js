/*!
 * Tooltip v1.0.16
 * https://sa-si-dev.github.io/tooltip
 * Licensed under MIT (https://github.com/sa-si-dev/tooltip/blob/master/LICENSE)
 */
/******/ (function() { // webpackBootstrap
var __webpack_exports__ = {};
// This entry need to be wrapped in an IIFE because it need to be isolated against other entry modules.
!function() {
/*!
 * Popper v1.0.4
 * https://sa-si-dev.github.io/popper
 * Licensed under MIT (https://github.com/sa-si-dev/popper/blob/master/LICENSE)
 */
/******/ (function() { // webpackBootstrap
/******/ 	"use strict";
var __webpack_exports__ = {};

// UNUSED EXPORTS: Popper

;// CONCATENATED MODULE: ./src/utils/dom-utils.js
function _typeof(o) { "@babel/helpers - typeof"; return _typeof = "function" == typeof Symbol && "symbol" == typeof Symbol.iterator ? function (o) { return typeof o; } : function (o) { return o && "function" == typeof Symbol && o.constructor === Symbol && o !== Symbol.prototype ? "symbol" : typeof o; }, _typeof(o); }
function _toConsumableArray(arr) { return _arrayWithoutHoles(arr) || _iterableToArray(arr) || _unsupportedIterableToArray(arr) || _nonIterableSpread(); }
function _nonIterableSpread() { throw new TypeError("Invalid attempt to spread non-iterable instance.\nIn order to be iterable, non-array objects must have a [Symbol.iterator]() method."); }
function _unsupportedIterableToArray(o, minLen) { if (!o) return; if (typeof o === "string") return _arrayLikeToArray(o, minLen); var n = Object.prototype.toString.call(o).slice(8, -1); if (n === "Object" && o.constructor) n = o.constructor.name; if (n === "Map" || n === "Set") return Array.from(o); if (n === "Arguments" || /^(?:Ui|I)nt(?:8|16|32)(?:Clamped)?Array$/.test(n)) return _arrayLikeToArray(o, minLen); }
function _iterableToArray(iter) { if (typeof Symbol !== "undefined" && iter[Symbol.iterator] != null || iter["@@iterator"] != null) return Array.from(iter); }
function _arrayWithoutHoles(arr) { if (Array.isArray(arr)) return _arrayLikeToArray(arr); }
function _arrayLikeToArray(arr, len) { if (len == null || len > arr.length) len = arr.length; for (var i = 0, arr2 = new Array(len); i < len; i++) arr2[i] = arr[i]; return arr2; }
function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }
function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, _toPropertyKey(descriptor.key), descriptor); } }
function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); Object.defineProperty(Constructor, "prototype", { writable: false }); return Constructor; }
function _toPropertyKey(arg) { var key = _toPrimitive(arg, "string"); return _typeof(key) === "symbol" ? key : String(key); }
function _toPrimitive(input, hint) { if (_typeof(input) !== "object" || input === null) return input; var prim = input[Symbol.toPrimitive]; if (prim !== undefined) { var res = prim.call(input, hint || "default"); if (_typeof(res) !== "object") return res; throw new TypeError("@@toPrimitive must return a primitive value."); } return (hint === "string" ? String : Number)(input); }
var DomUtils = /*#__PURE__*/function () {
  function DomUtils() {
    _classCallCheck(this, DomUtils);
  }
  _createClass(DomUtils, null, [{
    key: "addClass",
    value: function addClass($ele, className) {
      if (!$ele) {
        return;
      }
      className = className.split(' ');
      DomUtils.getElements($ele).forEach(function ($this) {
        var _$this$classList;
        (_$this$classList = $this.classList).add.apply(_$this$classList, _toConsumableArray(className));
      });
    }
  }, {
    key: "removeClass",
    value: function removeClass($ele, className) {
      if (!$ele) {
        return;
      }
      className = className.split(' ');
      DomUtils.getElements($ele).forEach(function ($this) {
        var _$this$classList2;
        (_$this$classList2 = $this.classList).remove.apply(_$this$classList2, _toConsumableArray(className));
      });
    }
  }, {
    key: "getElements",
    value: function getElements($ele) {
      if (!$ele) {
        return;
      }
      if ($ele.forEach === undefined) {
        $ele = [$ele];
      }
      return $ele;
    }
  }, {
    key: "getMoreVisibleSides",
    value: function getMoreVisibleSides($ele) {
      if (!$ele) {
        return {};
      }
      var box = $ele.getBoundingClientRect();
      var availableWidth = window.innerWidth;
      var availableHeight = window.innerHeight;
      var leftArea = box.left;
      var topArea = box.top;
      var rightArea = availableWidth - leftArea - box.width;
      var bottomArea = availableHeight - topArea - box.height;
      var horizontal = leftArea > rightArea ? 'left' : 'right';
      var vertical = topArea > bottomArea ? 'top' : 'bottom';
      return {
        horizontal: horizontal,
        vertical: vertical
      };
    }
  }, {
    key: "getAbsoluteCoords",
    value: function getAbsoluteCoords($ele) {
      if (!$ele) {
        return;
      }
      var box = $ele.getBoundingClientRect();
      var pageX = window.pageXOffset;
      var pageY = window.pageYOffset;
      return {
        width: box.width,
        height: box.height,
        top: box.top + pageY,
        right: box.right + pageX,
        bottom: box.bottom + pageY,
        left: box.left + pageX
      };
    }
  }, {
    key: "getCoords",
    value: function getCoords($ele) {
      return $ele ? $ele.getBoundingClientRect() : {};
    }
  }, {
    key: "getData",
    value: function getData($ele, name, type) {
      if (!$ele) {
        return;
      }
      var value = $ele ? $ele.dataset[name] : '';
      if (type === 'number') {
        value = parseFloat(value) || 0;
      } else {
        if (value === 'true') {
          value = true;
        } else if (value === 'false') {
          value = false;
        }
      }
      return value;
    }
  }, {
    key: "setData",
    value: function setData($ele, name, value) {
      if (!$ele) {
        return;
      }
      $ele.dataset[name] = value;
    }
  }, {
    key: "setStyle",
    value: function setStyle($ele, name, value) {
      if (!$ele) {
        return;
      }
      $ele.style[name] = value;
    }
  }, {
    key: "show",
    value: function show($ele) {
      var value = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : 'block';
      DomUtils.setStyle($ele, 'display', value);
    }
  }, {
    key: "hide",
    value: function hide($ele) {
      DomUtils.setStyle($ele, 'display', 'none');
    }

    /** getting parent element which could hide absolute positioned child */
  }, {
    key: "getHideableParent",
    value: function getHideableParent($ele) {
      var $hideableParent;
      var $parent = $ele.parentElement;
      while ($parent) {
        var overflowValue = getComputedStyle($parent).overflow;
        if (overflowValue.indexOf('scroll') !== -1 || overflowValue.indexOf('auto') !== -1) {
          $hideableParent = $parent;
          break;
        }
        $parent = $parent.parentElement;
      }
      return $hideableParent;
    }
  }]);
  return DomUtils;
}();
;// CONCATENATED MODULE: ./src/popper.js
function popper_typeof(o) { "@babel/helpers - typeof"; return popper_typeof = "function" == typeof Symbol && "symbol" == typeof Symbol.iterator ? function (o) { return typeof o; } : function (o) { return o && "function" == typeof Symbol && o.constructor === Symbol && o !== Symbol.prototype ? "symbol" : typeof o; }, popper_typeof(o); }
function popper_classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }
function popper_defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, popper_toPropertyKey(descriptor.key), descriptor); } }
function popper_createClass(Constructor, protoProps, staticProps) { if (protoProps) popper_defineProperties(Constructor.prototype, protoProps); if (staticProps) popper_defineProperties(Constructor, staticProps); Object.defineProperty(Constructor, "prototype", { writable: false }); return Constructor; }
function popper_toPropertyKey(arg) { var key = popper_toPrimitive(arg, "string"); return popper_typeof(key) === "symbol" ? key : String(key); }
function popper_toPrimitive(input, hint) { if (popper_typeof(input) !== "object" || input === null) return input; var prim = input[Symbol.toPrimitive]; if (prim !== undefined) { var res = prim.call(input, hint || "default"); if (popper_typeof(res) !== "object") return res; throw new TypeError("@@toPrimitive must return a primitive value."); } return (hint === "string" ? String : Number)(input); }

var allPositions = ['top', 'bottom', 'left', 'right'];
var allPositionsClass = allPositions.map(function (d) {
  return "position-".concat(d);
});
var arrowRotateMapping = {
  top: 'rotate(180deg)',
  left: 'rotate(90deg)',
  right: 'rotate(-90deg)'
};
var Popper = /*#__PURE__*/function () {
  /**
   * Create a Popper
   * @property {element} $popperEle - Popper element
   * @property {element} $triggerEle - Trigger element
   * @property {element} $arrowEle - Arrow icon in the popper
   * @property {string} [position=auto] - Position of popper (top, bottom, left, right, auto)
   * @property {number} [margin=8] - Space between popper and its activator (in pixel)
   * @property {number} [offset=5] - Space between popper and window edge (in pixel)
   * @property {number} [enterDelay=0] - Delay time before showing popper (in milliseconds)
   * @property {number} [exitDelay=0] - Delay time before hiding popper (in milliseconds)
   * @property {number} [showDuration=300] - Transition duration for show animation (in milliseconds)
   * @property {number} [hideDuration=200] - Transition duration for hide animation (in milliseconds)
   * @property {number} [transitionDistance=10] - Distance to translate on show/hide animation (in pixel)
   * @property {number} [zIndex=1] - CSS z-index value for popper
   * @property {function} [afterShow] - Callback function to trigger after show
   * @property {function} [afterHide] - Callback function to trigger after hide
   */
  function Popper(options) {
    popper_classCallCheck(this, Popper);
    try {
      this.setProps(options);
      this.init();
    } catch (e) {
      console.warn("Couldn't initiate popper");
      console.error(e);
    }
  }
  popper_createClass(Popper, [{
    key: "init",
    value: function init() {
      var $popperEle = this.$popperEle;
      if (!$popperEle || !this.$triggerEle) {
        return;
      }
      DomUtils.setStyle($popperEle, 'zIndex', this.zIndex);
      this.setPosition();
    }

    /** set methods - start */
  }, {
    key: "setProps",
    value: function setProps(options) {
      options = this.setDefaultProps(options);
      var position = options.position ? options.position.toLowerCase() : 'auto';
      this.$popperEle = options.$popperEle;
      this.$triggerEle = options.$triggerEle;
      this.$arrowEle = options.$arrowEle;
      this.margin = parseFloat(options.margin);
      this.offset = parseFloat(options.offset);
      this.enterDelay = parseFloat(options.enterDelay);
      this.exitDelay = parseFloat(options.exitDelay);
      this.showDuration = parseFloat(options.showDuration);
      this.hideDuration = parseFloat(options.hideDuration);
      this.transitionDistance = parseFloat(options.transitionDistance);
      this.zIndex = parseFloat(options.zIndex);
      this.afterShowCallback = options.afterShow;
      this.afterHideCallback = options.afterHide;
      this.hasArrow = this.$arrowEle ? true : false;
      if (position.indexOf(' ') !== -1) {
        var positionArray = position.split(' ');
        this.position = positionArray[0];
        this.secondaryPosition = positionArray[1];
      } else {
        this.position = position;
      }
    }
  }, {
    key: "setDefaultProps",
    value: function setDefaultProps(options) {
      var defaultOptions = {
        position: 'auto',
        margin: 8,
        offset: 5,
        enterDelay: 0,
        exitDelay: 0,
        showDuration: 300,
        hideDuration: 200,
        transitionDistance: 10,
        zIndex: 1
      };
      return Object.assign(defaultOptions, options);
    }
  }, {
    key: "setPosition",
    value: function setPosition() {
      DomUtils.show(this.$popperEle, 'inline-flex');
      var viewportWidth = window.innerWidth;
      var viewportHeight = window.innerHeight;
      var popperEleCoords = DomUtils.getAbsoluteCoords(this.$popperEle);
      var triggerEleCoords = DomUtils.getAbsoluteCoords(this.$triggerEle);
      var popperEleWidth = popperEleCoords.width;
      var popperEleHeight = popperEleCoords.height;
      var popperEleTop = popperEleCoords.top;
      var popperEleRight = popperEleCoords.right;
      var popperEleBotttom = popperEleCoords.bottom;
      var popperEleLeft = popperEleCoords.left;
      var triggerEleWidth = triggerEleCoords.width;
      var triggerEleHeight = triggerEleCoords.height;
      var triggerEleTop = triggerEleCoords.top;
      var triggerEleRight = triggerEleCoords.right;
      var triggerEleBottom = triggerEleCoords.bottom;
      var triggerEleLeft = triggerEleCoords.left;
      var topDiff = triggerEleTop - popperEleTop;
      var leftDiff = triggerEleLeft - popperEleLeft;
      var left = leftDiff;
      var top = topDiff;
      var position = this.position;
      var secondaryPosition = this.secondaryPosition;
      var widthCenter = triggerEleWidth / 2 - popperEleWidth / 2;
      var heightCenter = triggerEleHeight / 2 - popperEleHeight / 2;
      var margin = this.margin;
      var transitionDistance = this.transitionDistance;
      var fromTop;
      var fromLeft;
      var topEdge = window.scrollY - popperEleTop;
      var bottomEdge = viewportHeight + topEdge;
      var leftEdge = window.scrollX - popperEleLeft;
      var rightEdge = viewportWidth + leftEdge;
      var inversePosition;
      var viewportOffset = this.offset;
      if (viewportOffset) {
        topEdge += viewportOffset;
        bottomEdge -= viewportOffset;
        leftEdge += viewportOffset;
        rightEdge -= viewportOffset;
      }

      /** find the position which has more space */
      if (position === 'auto') {
        var moreVisibleSides = DomUtils.getMoreVisibleSides(this.$triggerEle);
        position = moreVisibleSides.vertical;
      }
      var positionsValue = {
        top: {
          top: top - popperEleHeight - margin,
          left: left + widthCenter
        },
        bottom: {
          top: top + triggerEleHeight + margin,
          left: left + widthCenter
        },
        right: {
          top: top + heightCenter,
          left: left + triggerEleWidth + margin
        },
        left: {
          top: top + heightCenter,
          left: left - popperEleWidth - margin
        }
      };
      var positionValue = positionsValue[position];
      top = positionValue.top;
      left = positionValue.left;

      /** setting secondary position value */
      if (secondaryPosition) {
        if (secondaryPosition === 'top') {
          top = topDiff;
        } else if (secondaryPosition === 'bottom') {
          top = topDiff + triggerEleHeight - popperEleHeight;
        } else if (secondaryPosition === 'left') {
          left = leftDiff;
        } else if (secondaryPosition === 'right') {
          left = leftDiff + triggerEleWidth - popperEleWidth;
        }
      }

      /* if popperEle is hiding on left edge */
      if (left < leftEdge) {
        if (position === 'left') {
          inversePosition = 'right';
        } else if (leftEdge + popperEleLeft > triggerEleRight) {
          /** if triggerEle is hiding on left edge */
          left = triggerEleRight - popperEleLeft;
        } else {
          left = leftEdge;
        }
      } else if (left + popperEleWidth > rightEdge) {
        /* if popperEle is hiding on right edge */
        if (position === 'right') {
          inversePosition = 'left';
        } else if (rightEdge + popperEleLeft < triggerEleLeft) {
          /** if triggerEle is hiding on right edge */
          left = triggerEleLeft - popperEleRight;
        } else {
          left = rightEdge - popperEleWidth;
        }
      }

      /* if popperEle is hiding on top edge */
      if (top < topEdge) {
        if (position === 'top') {
          inversePosition = 'bottom';
        } else if (topEdge + popperEleTop > triggerEleBottom) {
          /** if triggerEle is hiding on top edge */
          top = triggerEleBottom - popperEleTop;
        } else {
          top = topEdge;
        }
      } else if (top + popperEleHeight > bottomEdge) {
        /* if popperEle is hiding on bottom edge */
        if (position === 'bottom') {
          inversePosition = 'top';
        } else if (bottomEdge + popperEleTop < triggerEleTop) {
          /** if triggerEle is hiding on bottom edge */
          top = triggerEleTop - popperEleBotttom;
        } else {
          top = bottomEdge - popperEleHeight;
        }
      }

      /** if popper element is hidden in the given position, show it on opposite position */
      if (inversePosition) {
        var inversePositionValue = positionsValue[inversePosition];
        position = inversePosition;
        if (position === 'top' || position === 'bottom') {
          top = inversePositionValue.top;
        } else if (position === 'left' || position === 'right') {
          left = inversePositionValue.left;
        }
      }
      if (position === 'top') {
        fromTop = top + transitionDistance;
        fromLeft = left;
      } else if (position === 'right') {
        fromTop = top;
        fromLeft = left - transitionDistance;
      } else if (position === 'left') {
        fromTop = top;
        fromLeft = left + transitionDistance;
      } else {
        fromTop = top - transitionDistance;
        fromLeft = left;
      }
      var transformText = "translate3d(".concat(fromLeft, "px, ").concat(fromTop, "px, 0)");
      DomUtils.setStyle(this.$popperEle, 'transform', transformText);
      DomUtils.setData(this.$popperEle, 'fromLeft', fromLeft);
      DomUtils.setData(this.$popperEle, 'fromTop', fromTop);
      DomUtils.setData(this.$popperEle, 'top', top);
      DomUtils.setData(this.$popperEle, 'left', left);
      DomUtils.removeClass(this.$popperEle, allPositionsClass.join(' '));
      DomUtils.addClass(this.$popperEle, "position-".concat(position));
      if (this.hasArrow) {
        var arrowLeft = 0;
        var arrowTop = 0;
        var fullLeft = left + popperEleLeft;
        var fullTop = top + popperEleTop;
        var arrowWidthHalf = this.$arrowEle.offsetWidth / 2;
        var rotateText = arrowRotateMapping[position] || '';
        if (position === 'top' || position === 'bottom') {
          var triggerEleWidthCenter = triggerEleWidth / 2 + triggerEleLeft;
          arrowLeft = triggerEleWidthCenter - fullLeft;

          /** if arrow crossed left edge of popper element */
          if (arrowLeft < arrowWidthHalf) {
            arrowLeft = arrowWidthHalf;
          } else if (arrowLeft > popperEleWidth - arrowWidthHalf) {
            /** if arrow crossed right edge of popper element */
            arrowLeft = popperEleWidth - arrowWidthHalf;
          }
        } else if (position === 'left' || position === 'right') {
          var triggerEleHeightCenter = triggerEleHeight / 2 + triggerEleTop;
          arrowTop = triggerEleHeightCenter - fullTop;

          /** if arrow crossed top edge of popper element */
          if (arrowTop < arrowWidthHalf) {
            arrowTop = arrowWidthHalf;
          } else if (arrowTop > popperEleHeight - arrowWidthHalf) {
            /** if arrow crossed bottom edge of popper element */
            arrowTop = popperEleHeight - arrowWidthHalf;
          }
        }
        DomUtils.setStyle(this.$arrowEle, 'transform', "translate3d(".concat(arrowLeft, "px, ").concat(arrowTop, "px, 0) ").concat(rotateText));
      }
      DomUtils.hide(this.$popperEle);
    }
  }, {
    key: "resetPosition",
    value: function resetPosition() {
      DomUtils.setStyle(this.$popperEle, 'transform', 'none');
      this.setPosition();
    }
    /** set methods - end */

    /**
     * @prop {boolean} [resetPosition] - Recalculate position before show
     * @prop {object} [data] - Any custom data which would be passed to afterShow callback function call
     */
  }, {
    key: "show",
    value: function show() {
      var _this = this;
      var _ref = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : {},
        resetPosition = _ref.resetPosition,
        data = _ref.data;
      clearTimeout(this.exitDelayTimeout);
      clearTimeout(this.hideDurationTimeout);
      if (resetPosition) {
        this.resetPosition();
      }
      this.enterDelayTimeout = setTimeout(function () {
        var left = DomUtils.getData(_this.$popperEle, 'left');
        var top = DomUtils.getData(_this.$popperEle, 'top');
        var transformText = "translate3d(".concat(left, "px, ").concat(top, "px, 0)");
        var showDuration = _this.showDuration;
        DomUtils.show(_this.$popperEle, 'inline-flex');

        /** calling below method to force redraw - it would move the popper element to its fromLeft and fromTop position */
        DomUtils.getCoords(_this.$popperEle);
        DomUtils.setStyle(_this.$popperEle, 'transitionDuration', showDuration + 'ms');
        DomUtils.setStyle(_this.$popperEle, 'transform', transformText);
        DomUtils.setStyle(_this.$popperEle, 'opacity', 1);
        _this.showDurationTimeout = setTimeout(function () {
          if (typeof _this.afterShowCallback === 'function') {
            _this.afterShowCallback(data);
          }
        }, showDuration);
      }, this.enterDelay);
    }

    /**
     * @prop {object} [data] - Any custom data which would be passed to afterHide callback function call
     */
  }, {
    key: "hide",
    value: function hide() {
      var _this2 = this;
      var _ref2 = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : {},
        data = _ref2.data;
      clearTimeout(this.enterDelayTimeout);
      clearTimeout(this.showDurationTimeout);
      this.exitDelayTimeout = setTimeout(function () {
        if (_this2.$popperEle) {
          var left = DomUtils.getData(_this2.$popperEle, 'fromLeft');
          var top = DomUtils.getData(_this2.$popperEle, 'fromTop');
          var transformText = "translate3d(".concat(left, "px, ").concat(top, "px, 0)");
          var hideDuration = _this2.hideDuration;
          DomUtils.setStyle(_this2.$popperEle, 'transitionDuration', hideDuration + 'ms');
          DomUtils.setStyle(_this2.$popperEle, 'transform', transformText);
          DomUtils.setStyle(_this2.$popperEle, 'opacity', 0);
          _this2.hideDurationTimeout = setTimeout(function () {
            DomUtils.hide(_this2.$popperEle);
            if (typeof _this2.afterHideCallback === 'function') {
              _this2.afterHideCallback(data);
            }
          }, hideDuration);
        }
      }, this.exitDelay);
    }
  }, {
    key: "updatePosition",
    value: function updatePosition() {
      DomUtils.setStyle(this.$popperEle, 'transitionDuration', '0ms');
      this.resetPosition();
      var left = DomUtils.getData(this.$popperEle, 'left');
      var top = DomUtils.getData(this.$popperEle, 'top');
      DomUtils.show(this.$popperEle, 'inline-flex');
      DomUtils.setStyle(this.$popperEle, 'transform', "translate3d(".concat(left, "px, ").concat(top, "px, 0)"));
    }
  }]);
  return Popper;
}();
window.PopperComponent = Popper;
/******/ })()
;
}();
// This entry need to be wrapped in an IIFE because it need to be in strict mode.
!function() {
"use strict";

;// CONCATENATED MODULE: ./src/utils/utils.js
function _typeof(o) { "@babel/helpers - typeof"; return _typeof = "function" == typeof Symbol && "symbol" == typeof Symbol.iterator ? function (o) { return typeof o; } : function (o) { return o && "function" == typeof Symbol && o.constructor === Symbol && o !== Symbol.prototype ? "symbol" : typeof o; }, _typeof(o); }
function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }
function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, _toPropertyKey(descriptor.key), descriptor); } }
function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); Object.defineProperty(Constructor, "prototype", { writable: false }); return Constructor; }
function _toPropertyKey(arg) { var key = _toPrimitive(arg, "string"); return _typeof(key) === "symbol" ? key : String(key); }
function _toPrimitive(input, hint) { if (_typeof(input) !== "object" || input === null) return input; var prim = input[Symbol.toPrimitive]; if (prim !== undefined) { var res = prim.call(input, hint || "default"); if (_typeof(res) !== "object") return res; throw new TypeError("@@toPrimitive must return a primitive value."); } return (hint === "string" ? String : Number)(input); }
var Utils = /*#__PURE__*/function () {
  function Utils() {
    _classCallCheck(this, Utils);
  }
  _createClass(Utils, null, [{
    key: "convertToBoolean",
    value: function convertToBoolean(value) {
      var defaultValue = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : false;
      if (value === true || value === 'true') {
        value = true;
      } else if (value === false || value === 'false') {
        value = false;
      } else {
        value = defaultValue;
      }
      return value;
    }
  }, {
    key: "convertToFloat",
    value: function convertToFloat(value) {
      var defaultValue = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : 0;
      return value !== undefined ? parseFloat(value) : defaultValue;
    }
  }]);
  return Utils;
}();
;// CONCATENATED MODULE: ./src/utils/dom-utils.js
function dom_utils_typeof(o) { "@babel/helpers - typeof"; return dom_utils_typeof = "function" == typeof Symbol && "symbol" == typeof Symbol.iterator ? function (o) { return typeof o; } : function (o) { return o && "function" == typeof Symbol && o.constructor === Symbol && o !== Symbol.prototype ? "symbol" : typeof o; }, dom_utils_typeof(o); }
function dom_utils_classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }
function dom_utils_defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, dom_utils_toPropertyKey(descriptor.key), descriptor); } }
function dom_utils_createClass(Constructor, protoProps, staticProps) { if (protoProps) dom_utils_defineProperties(Constructor.prototype, protoProps); if (staticProps) dom_utils_defineProperties(Constructor, staticProps); Object.defineProperty(Constructor, "prototype", { writable: false }); return Constructor; }
function dom_utils_toPropertyKey(arg) { var key = dom_utils_toPrimitive(arg, "string"); return dom_utils_typeof(key) === "symbol" ? key : String(key); }
function dom_utils_toPrimitive(input, hint) { if (dom_utils_typeof(input) !== "object" || input === null) return input; var prim = input[Symbol.toPrimitive]; if (prim !== undefined) { var res = prim.call(input, hint || "default"); if (dom_utils_typeof(res) !== "object") return res; throw new TypeError("@@toPrimitive must return a primitive value."); } return (hint === "string" ? String : Number)(input); }
var DomUtils = /*#__PURE__*/function () {
  function DomUtils() {
    dom_utils_classCallCheck(this, DomUtils);
  }
  dom_utils_createClass(DomUtils, null, [{
    key: "hasEllipsis",
    value: function hasEllipsis($ele) {
      if (!$ele) {
        return false;
      }
      return $ele.scrollWidth > $ele.offsetWidth;
    }
  }, {
    key: "setStyle",
    value: function setStyle($ele, name, value) {
      if (!$ele) {
        return;
      }
      $ele.style[name] = value;
    }
  }, {
    key: "getScrollableParents",
    value: function getScrollableParents($ele) {
      if (!$ele) {
        return [];
      }
      var $scrollableElems = [window];
      var $parent = $ele.parentElement;
      while ($parent) {
        var overflowValue = getComputedStyle($parent).overflow;
        if (overflowValue.indexOf('scroll') !== -1 || overflowValue.indexOf('auto') !== -1) {
          $scrollableElems.push($parent);
        }
        $parent = $parent.parentElement;
      }
      return $scrollableElems;
    }
  }]);
  return DomUtils;
}();
;// CONCATENATED MODULE: ./src/tooltip.js


/**
 * Available data attributes (data-tooltip-*)
 * @property {string} tooltip - Text to show (data-tooltip="")
 * @property {string} [position=auto] - Position of tooltip (top, bottom, left, right, auto)
 * @property {string} [fontSize=14px] - Text font size
 * @property {number} [margin=8] - Space between tooltip and its activator (in pixel)
 * @property {number} [offset=5] - Space between tooltip and window edge (in pixel)
 * @property {number} [enterDelay=0] - Delay time before showing tooltip (in milliseconds)
 * @property {number} [exitDelay=0] - Delay time before hiding tooltip (in milliseconds)
 * @property {number} [showDuration=300] - Transition duration for show animation (in milliseconds)
 * @property {number} [hideDuration=200] - Transition duration for hide animation (in milliseconds)
 * @property {number} [transitionDistance=10] - Distance to translate on show/hide animation (in pixel)
 * @property {number} [zIndex=1] - CSS z-index value for tooltip
 * @property {boolean} [ellipsisOnly=false] - Show the tooltip only if element text is partially hidden with ellipsis
 * @property {boolean} [allowHtml=false] - Allow html elements in the tooltip text
 * @property {string} [alignment=left] - CSS text-align value
 * @property {string} [maxWidth=300px] - CSS max-width for tootltip box
 * @property {boolean} [hideOnClick=true] - Hide tooltip on clicking the element
 * @property {boolean} [hideArrowIcon=false] - Hide arrow icon in the tooltip
 * @property {string} [additionalClasses] - Additional classes for tooltip which could be used to customize tooltip in CSS
 */
(function () {
  if (window.tooltipComponentInitiated) {
    return;
  } else {
    window.tooltipComponentInitiated = true;
  }
  var $body;
  var $popperEle;
  var $triggerEle;
  var $arrowEle;
  var $scrollableElems;
  var options = {};
  var popper;
  var isInitiated = false;
  initTooltip();
  window.addEventListener('load', initTooltip);
  function initTooltip() {
    if (isInitiated) {
      return;
    }
    $body = document.querySelector('body');
    if (!$body) {
      return;
    }
    addEvents();
    isInitiated = true;
  }

  /** event methods - start */
  function addEvents() {
    document.addEventListener('mouseover', onMouseOver);
    document.addEventListener('mouseout', onMouseOut);
    document.addEventListener('touchmove', onTouchMove);
    document.addEventListener('click', onClick);
  }
  function onMouseOver(e) {
    if ($triggerEle) {
      return;
    }
    var target = e.target.closest('[data-tooltip]');
    if (!target) {
      return;
    }
    $triggerEle = target;
    showTooltip();
  }
  function onMouseOut(e) {
    if (!$triggerEle) {
      return;
    }
    var target = e.relatedTarget;
    while (target) {
      if (target === $triggerEle) {
        return;
      }
      target = target.parentNode;
    }
    hideTooltip();
  }
  function onTouchMove() {
    hideTooltip();
  }
  function onClick() {
    if (options.hideOnClick) {
      hideTooltip();
    }
  }
  /** event methods - end */

  function showTooltip() {
    if (!$triggerEle) {
      return;
    }
    var convertToBoolean = Utils.convertToBoolean;
    var convertToFloat = Utils.convertToFloat;
    var dataset = $triggerEle.dataset;
    options = {
      tooltip: dataset.tooltip,
      position: dataset.tooltipPosition || 'auto',
      zIndex: convertToFloat(dataset.tooltipZIndex, 1),
      enterDelay: convertToFloat(dataset.tooltipEnterDelay, 0),
      exitDelay: convertToFloat(dataset.tooltipExitDelay, 0),
      fontSize: dataset.tooltipFontSize || '14px',
      margin: convertToFloat(dataset.tooltipMargin, 8),
      offset: convertToFloat(dataset.tooltipOffset, 5),
      showDuration: convertToFloat(dataset.tooltipShowDuration, 300),
      hideDuration: convertToFloat(dataset.tooltipHideDuration, 200),
      transitionDistance: convertToFloat(dataset.tooltipTransitionDistance, 10),
      ellipsisOnly: convertToBoolean(dataset.tooltipEllipsisOnly),
      allowHtml: convertToBoolean(dataset.tooltipAllowHtml),
      hideOnClick: convertToBoolean(dataset.tooltipHideOnClick, true),
      hideArrowIcon: convertToBoolean(dataset.tooltipHideArrowIcon),
      alignment: dataset.tooltipAlignment || 'left',
      maxWidth: dataset.tooltipMaxWidth || '300px',
      additionalClasses: dataset.tooltipAdditionalClasses
    };
    if (!options.tooltip || isTooltipDisabled()) {
      hideTooltip();
      return;
    }
    removeTooltip();
    renderTooltip();
    initPopper();
    addScrollEventListeners();
  }
  function renderTooltip() {
    var classNames = 'tooltip-comp';
    if (options.hideArrowIcon) {
      classNames += ' hide-arrow-icon';
    }
    if (options.additionalClasses) {
      classNames += ' ' + options.additionalClasses;
    }
    var html = "<div class=\"".concat(classNames, "\">\n        <i class=\"tooltip-comp-arrow\"></i>\n        <div class=\"tooltip-comp-content\"></div>\n      </div>");
    $body.insertAdjacentHTML('beforeend', html);
    var setStyle = DomUtils.setStyle;
    $popperEle = document.querySelector('.tooltip-comp');
    $arrowEle = $popperEle.querySelector('.tooltip-comp-arrow');
    var $popperContent = $popperEle.querySelector('.tooltip-comp-content');
    if (options.allowHtml) {
      $popperContent.innerHTML = options.tooltip;
    } else {
      $popperContent.innerText = options.tooltip;
    }
    setStyle($popperEle, 'zIndex', options.zIndex);
    setStyle($popperEle, 'fontSize', options.fontSize);
    setStyle($popperEle, 'textAlign', options.alignment);
    setStyle($popperEle, 'maxWidth', options.maxWidth);
  }
  function hideTooltip() {
    if (!isTooltipShown()) {
      return;
    }
    hidePopper();
    removeScrollEventListeners();
    $triggerEle = null;
  }
  function removeTooltip() {
    if ($popperEle) {
      $popperEle.remove();
    }
  }
  function isTooltipDisabled() {
    return options.ellipsisOnly && !DomUtils.hasEllipsis($triggerEle);
  }
  function initPopper() {
    var data = {
      $popperEle: $popperEle,
      $triggerEle: $triggerEle,
      $arrowEle: $arrowEle,
      position: options.position,
      margin: options.margin,
      offset: options.offset,
      enterDelay: options.enterDelay,
      exitDelay: options.exitDelay,
      showDuration: options.showDuration,
      hideDuration: options.hideDuration,
      transitionDistance: options.transitionDistance,
      zIndex: options.zIndex
    };
    popper = new PopperComponent(data);
    popper.show();
  }
  function hidePopper() {
    if (popper) {
      popper.hide();
    }
  }
  function isTooltipShown() {
    return $popperEle || $triggerEle;
  }
  function addScrollEventListeners() {
    $scrollableElems = DomUtils.getScrollableParents($triggerEle);
    $scrollableElems.forEach(function ($ele) {
      $ele.addEventListener('scroll', onScroll);
    });
  }
  function removeScrollEventListeners() {
    if (!$scrollableElems) {
      return;
    }
    $scrollableElems.forEach(function ($ele) {
      $ele.removeEventListener('scroll', onScroll);
    });
    $scrollableElems = null;
  }
  function onScroll() {
    hideTooltip();
  }
})();
}();
/******/ })()
;