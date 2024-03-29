import { element, getjQuery, onDOMContentLoaded } from '../mdb/util/index';
import Data from '../mdb/dom/data';
import EventHandler from '../mdb/dom/event-handler';
import Manipulator from '../mdb/dom/manipulator';
import SelectorEngine from '../mdb/dom/selector-engine';

/**
 * ------------------------------------------------------------------------
 * Constants
 * ------------------------------------------------------------------------
 */

const NAME = 'select';
const DATA_KEY = 'mdb.select';
const CLASSNAME_WRAPPER = 'select-outline';
const CLASSNAME_ACTIVE = 'active';
const CLASSNAME_NOTCH = 'form-notch';
const CLASSNAME_NOTCH_LEADING = 'form-notch-leading';
const CLASSNAME_NOTCH_MIDDLE = 'form-notch-middle';
const CLASSNAME_NOTCH_TRAILING = 'form-notch-trailing';
const CLASSNAME_PLACEHOLDER_ACTIVE = 'placeholder-active';
const CLASSNAME_HELPER = 'form-helper';
const CLASSNAME_COUNTER = 'form-counter';

const SELECTOR_OUTLINE_SELECT = `.${CLASSNAME_WRAPPER} select`;
const SELECTOR_NOTCH = `.${CLASSNAME_NOTCH}`;
const SELECTOR_NOTCH_LEADING = `.${CLASSNAME_NOTCH_LEADING}`;
const SELECTOR_NOTCH_MIDDLE = `.${CLASSNAME_NOTCH_MIDDLE}`;
const SELECTOR_HELPER = `.${CLASSNAME_HELPER}`;

/**
 * ------------------------------------------------------------------------
 * Class Definition
 * ------------------------------------------------------------------------
 */

class Select {
  constructor(element) {
    this._element = element;
    this._label = null;
    this._labelWidth = 0;
    this._labelMarginLeft = 0;
    this._notchLeading = null;
    this._notchMiddle = null;
    this._notchTrailing = null;
    this._initiated = false;
    this._helper = null;
    this._counter = false;
    this._counterElement = null;
    this._maxLength = 0;
    this._leadingIcon = null;
    if (this._element) {
      Data.setData(element, DATA_KEY, this);
      this.init();
    }
  }

  // Getters
  static get NAME() {
    return NAME;
  }

  get select() {
    return SelectorEngine.findOne('select', this._element);
  }

  // Public
  init() {
    if (this._initiated) {
      return;
    }
    this._getLabelData();
    this._applyDivs();
    this._applyNotch();
    this._activate();
    this._getHelper();
    this._getCounter();
    this._initiated = true;
  }

  update() {
    this._getLabelData();
    this._getNotchData();
    this._applyNotch();
    this._activate();
    this._getHelper();
    this._getCounter();
  }

  forceActive() {
    Manipulator.addClass(this.select, CLASSNAME_ACTIVE);
  }

  forceInactive() {
    Manipulator.removeClass(this.select, CLASSNAME_ACTIVE);
  }

  dispose() {
    this._removeBorder();

    Data.removeData(this._element, DATA_KEY);
    this._element = null;
  }

  // Private

  /*
  _getIcons() {
    this._leadingIcon = SelectorEngine.findOne('i.leading', this._element);

    if (this._leadingIcon !== null) {
      this._applyLeadingIcon();
    }
  }

  _applyLeadingIcon() {
    this._label.innerHTML = ` ${this._label.innerHTML}`;
    this._label.insertBefore(this._leadingIcon, this._label.firstChild);
  }
  */

  _getLabelData() {
    this._label = SelectorEngine.findOne('label', this._element);
    if (this._label === null) {
      this._showPlaceholder();
    } else {
      this._getLabelWidth();
      this._getLabelPositionInInputGroup();
    }
  }

  _getHelper() {
    this._helper = SelectorEngine.findOne(SELECTOR_HELPER, this._element);
  }

  _getCounter() {
    this._counter = Manipulator.getDataAttribute(this.select, 'showcounter');
    if (this._counter) {
      this._maxLength = this.select.maxLength;
      this._showCounter();
    }
  }

  _showCounter() {
    const counters = SelectorEngine.find('.form-counter', this._element);
    if (counters.length > 0) {
      return;
    }
    this._counterElement = document.createElement('div');
    Manipulator.addClass(this._counterElement, CLASSNAME_COUNTER);
    const actualLength = this.select.value.length;
    this._counterElement.innerHTML = `${actualLength} / ${this._maxLength}`;
    this._helper.appendChild(this._counterElement);
    this._bindCounter();
  }

  _bindCounter() {
    EventHandler.on(this.select, 'select', () => {
      const actualLength = this.select.value.length;
      this._counterElement.innerHTML = `${actualLength} / ${this._maxLength}`;
    });
  }

  _showPlaceholder() {
    Manipulator.addClass(this.select, CLASSNAME_PLACEHOLDER_ACTIVE);
  }

  _getNotchData() {
    this._notchMiddle = SelectorEngine.findOne(SELECTOR_NOTCH_MIDDLE, this._element);
    this._notchLeading = SelectorEngine.findOne(SELECTOR_NOTCH_LEADING, this._element);
  }

  _getLabelWidth() {
    this._labelWidth = this._label.clientWidth * 0.8 + 8;
  }

  _getLabelPositionInInputGroup() {
    this._labelMarginLeft = 0;

    if (!this._element.classList.contains('input-group')) return;
    const select = this.select;
    const prefix = SelectorEngine.prev(select, '.input-group-text')[0];
    if (prefix === undefined) {
      this._labelMarginLeft = 0;
    } else {
      this._labelMarginLeft = prefix.offsetWidth - 1;
    }
  }

  _applyDivs() {
    const allNotchWrappers = SelectorEngine.find(SELECTOR_NOTCH, this._element);
    const notchWrapper = element('div');
    Manipulator.addClass(notchWrapper, CLASSNAME_NOTCH);
    this._notchLeading = element('div');
    Manipulator.addClass(this._notchLeading, CLASSNAME_NOTCH_LEADING);
    this._notchMiddle = element('div');
    Manipulator.addClass(this._notchMiddle, CLASSNAME_NOTCH_MIDDLE);
    this._notchTrailing = element('div');
    Manipulator.addClass(this._notchTrailing, CLASSNAME_NOTCH_TRAILING);
    if (allNotchWrappers.length >= 1) {
      return;
    }
    notchWrapper.append(this._notchLeading);
    notchWrapper.append(this._notchMiddle);
    notchWrapper.append(this._notchTrailing);
    this._element.append(notchWrapper);
  }

  _applyNotch() {
    this._notchMiddle.style.width = `${this._labelWidth}px`;
    this._notchLeading.style.width = `${this._labelMarginLeft + 9}px`;

    if (this._label === null) return;
    this._label.style.marginLeft = `${this._labelMarginLeft}px`;
  }

  _removeBorder() {
    const border = SelectorEngine.findOne(SELECTOR_NOTCH, this._element);
    if (border) border.remove();
  }

  _activate(event) {
    onDOMContentLoaded(() => {
      this._getElements(event);
      const select = event ? event.target : this.select;

      if (select.value !== '') {
        Manipulator.addClass(select, CLASSNAME_ACTIVE);
      }
    });
  }

  _getElements(event) {
    if (event) {
      this._element = event.target.parentNode;
      this._label = SelectorEngine.findOne('label', this._element);
    }

    if (event && this._label) {
      const prevLabelWidth = this._labelWidth;
      this._getLabelData();

      if (prevLabelWidth !== this._labelWidth) {
        this._notchMiddle = SelectorEngine.findOne('.form-notch-middle', event.target.parentNode);
        this._notchLeading = SelectorEngine.findOne(
          SELECTOR_NOTCH_LEADING,
          event.target.parentNode
        );
        this._applyNotch();
      }
    }
  }

  _deactivate(event) {
    const select = event ? event.target : this.select;

    if (select.value === '') {
      select.classList.remove(CLASSNAME_ACTIVE);
    }
  }

  static activate(instance) {
    return function (event) {
      instance._activate(event);
    };
  }

  static deactivate(instance) {
    return function (event) {
      instance._deactivate(event);
    };
  }

  static jQueryInterface(config, options) {
    return this.each(function () {
      let data = Data.getData(this, DATA_KEY);
      const _config = typeof config === 'object' && config;
      if (!data && /dispose/.test(config)) {
        return;
      }
      if (!data) {
        data = new Select(this, _config);
      }
      if (typeof config === 'string') {
        if (typeof data[config] === 'undefined') {
          throw new TypeError(`No method named "${config}"`);
        }
        data[config](options);
      }
    });
  }

  static getInstance(element) {
    return Data.getData(element, DATA_KEY);
  }

  static getOrCreateInstance(element, config = {}) {
    return (
      this.getInstance(element) || new this(element, typeof config === 'object' ? config : null)
    );
  }
}

EventHandler.on(document, 'focus', SELECTOR_OUTLINE_SELECT, Select.activate(new Select()));
EventHandler.on(document, 'input', SELECTOR_OUTLINE_SELECT, Select.activate(new Select()));
EventHandler.on(document, 'blur', SELECTOR_OUTLINE_SELECT, Select.deactivate(new Select()));

EventHandler.on(window, 'shown.bs.modal', (e) => {
  SelectorEngine.find(SELECTOR_OUTLINE_SELECT, e.target).forEach((element) => {
    const instance = Select.getInstance(element.parentNode);
    if (!instance) {
      return;
    }
    instance.update();
  });
});

EventHandler.on(window, 'shown.bs.dropdown', (e) => {
  const target = e.target.parentNode.querySelector('.dropdown-menu');
  if (target) {
    SelectorEngine.find(SELECTOR_OUTLINE_SELECT, target).forEach((element) => {
      const instance = Select.getInstance(element.parentNode);
      if (!instance) {
        return;
      }
      instance.update();
    });
  }
});

EventHandler.on(window, 'shown.bs.tab', (e) => {
  let targetId;

  if (e.target.href) {
    targetId = e.target.href.split('#')[1];
  } else {
    targetId = Manipulator.getDataAttribute(e.target, 'target').split('#')[1];
  }

  const target = SelectorEngine.findOne(`#${targetId}`);
  SelectorEngine.find(SELECTOR_OUTLINE_SELECT, target).forEach((element) => {
    const instance = elect.getInstance(element.parentNode);
    if (!instance) {
      return;
    }
    instance.update();
  });
});

// auto-init
SelectorEngine.find(`.${CLASSNAME_WRAPPER}`).map((element) => new Select(element));

// form reset handler
EventHandler.on(window, 'reset', (e) => {
  SelectorEngine.find(SELECTOR_OUTLINE_SELECT, e.target).forEach((element) => {
    const instance = Select.getInstance(element.parentNode);
    if (!instance) {
      return;
    }
    instance.forceInactive();
  });
});

onDOMContentLoaded(() => {
  const $ = getjQuery();

  if ($) {
    const JQUERY_NO_CONFLICT = $.fn[NAME];
    $.fn[NAME] = Select.jQueryInterface;
    $.fn[NAME].Constructor = Select;
    $.fn[NAME].noConflict = () => {
      $.fn[NAME] = JQUERY_NO_CONFLICT;
      return Select.jQueryInterface;
    };
  }
});

export default Select;
