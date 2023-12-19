import { createSlice } from '@reduxjs/toolkit';


const Selector = [
    {
        type:'Class', 
        Syntax: '.intro, .header, .body etc...',
        Explainations: `The .class selector selects elements with a specific class attribute.

        To select elements with a specific class, write a period (.) character, followed by the name of the class.
        
        You can also specify that only specific HTML elements should be affected by a class. To do this, start with the element name, then write the period (.) character, followed by the name of the class.`,
        link:'https://developer.mozilla.org/en-US/docs/Web/CSS/Class_selectors'
    },
    {
        type:'ID', 
        Syntax: '#username-input, #branding-title, #card-content etc...',
        Explainations: `The id selector uses the id attribute of an HTML element to select a specific element.

        The id of an element is unique within a page, so the id selector is used to select one unique element!
        
        To select an element with a specific id, write a hash (#) character, followed by the id of the element.`,
        link:'https://developer.mozilla.org/en-US/docs/Web/CSS/ID_selectors'
    },
    {
        type:'Tag', 
        Syntax: 'body, div, input etc...',
        Explainations: `The element selector selects HTML elements based on the element name.`,
        link:'https://developer.mozilla.org/en-US/docs/Learn/CSS/Building_blocks/Selectors/Type_Class_and_ID_Selectors'
    },
    {
        type:'Pseudo-classes', 
        Syntax: ':hover, :checked, :visited etc...',
        Explainations: `A CSS pseudo-class is a keyword added to a selector that specifies a special state of the selected element(s). For example, the pseudo-class :hover can be used to select a button when a user's pointer hovers over the button and this selected button can then be styled.`,
        link:'https://developer.mozilla.org/en-US/docs/Web/CSS/Pseudo-classes'
    },
    {
        type:'Pseudo-Element', 
        Syntax: '::after, ::before, ::first-line etc...',
        Explainations: `A CSS pseudo-element is a keyword added to a selector that lets you style a specific part of the selected element(s). ::first-line can be used to change the font of the first line of a paragraph.`,
        link:'https://developer.mozilla.org/en-US/docs/Web/CSS/Pseudo-elements'
    },
    {
        type:'Combinators', 
        Syntax: '.container > li, .container + a, #input-username ~ p',
        Explainations: `A CSS selector can contain more than one simple selector. Between the simple selectors, we can include a combinator.

        There are four different combinators in CSS:
        
        descendant selector (space)
        child selector (>)
        adjacent sibling selector (+)
        general sibling selector (~)`,
        link:'https://developer.mozilla.org/en-US/docs/Learn/CSS/Building_blocks/Selectors/Combinators'
    }
] 

const pseudoClasses = [
    ':first-child',
    ':last-child',
    ':nth-child(even)',
    ':nth-child(odd)',
    ':active',
    ':checked',
    ':visited',
    ':hover',
  ]
  
  const pseudoElements = [
    '::before',
    '::after',
    '::first-letter',
    '::first-line',
  ]

  const taglist = [
    'div',
    'p',
    'input',
    'a',
    'button',
    'span',
    'ul',
    'li',
    'ol',
    'form',
    'label',
    'h1',
    'h2',
    'legend',
    'textarea',
    'select',
    'option',
    'table',
    'tr',
    'td',
    'th',
    'img',
    'section',
    'article',
    'nav',
    'fieldset',
    'figcaption',
    'figure',
  ]

  const combinators = [
    ' ',
    ' > ',
    ' + ',
    ' ~ ',
  ]

function getselectorData(selectorType){
    return Selector.find((selector) => selector.type === selectorType)
}

function getSelectorType(selector){
    if(selector[0] == '#')
        return 'ID';
    else if (selector[0] == '.')
        return 'Class';
    else if(taglist.includes(selector))
        return 'Tag';
    else if(pseudoClasses.includes(selector))
        return 'Pseudo-classes';
    else if (pseudoElements.includes(selector))
        return 'Pseudo-Element';
    else if (combinators.includes(selector))
        return 'Combinators'
}

const initialState = {
    selectorType: '',
    selectedSelector: '',
    selectordata: '',
};

const SelectorSlice = createSlice({
    name: 'SelectorSlice',
    initialState,
    reducers: {
      // all the reducers here
      setSelector: (state, action) =>{
        state.selectorType = getSelectorType(action.payload);
        state.selectedSelector = action.payload;
        state.selectordata = getselectorData(state.selectorType);
      }
    },
    extraReducers: (builder) => {
        builder
    }
})

export const {setSelector} = SelectorSlice.actions;
export default SelectorSlice.reducer;