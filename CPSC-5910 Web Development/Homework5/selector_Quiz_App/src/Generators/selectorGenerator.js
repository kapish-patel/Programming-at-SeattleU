/*
Copyright 2023 Tim Spinney

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS “AS IS” AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

const tagNames = [
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

const names = [
  'broccoli',
  'kale',
  'spinach',
  'pea',
  'carrot',
  'broccolini',
  'cabbage',
  'cauliflower',
  'cilantro',
  'basil',
  'parsley',
  'cardamom',
  'cinnamon',
  'clove',
  'cumin',
  'ginger',
  'garam-masala',
  'turmeric',
]

const combinators = [
  ' ',
  ' > ',
  ' + ',
  ' ~ ',
]

/* Takes an array and a number of elements. Samples n elements from array
   without replacement and returns samples. Used to avoid redundant class
   names and pseudo-classes.
 */
function sampleFromArray(array, n) {
  let options = [...array]
  const samples = []
  for(let i = 0; i < n; i++) {
    const index = Math.floor(Math.random() * options.length)
    samples.push(options[index])
    options.splice(index, 1)
  }
  return samples
}

const tagGenerator = () => tagNames[Math.floor(Math.random() * tagNames.length)]
const idGenerator =  () => `#${names[Math.floor(Math.random() * names.length)]}`
const classGenerator = n => sampleFromArray(names, n).map(name => `.${name}`)
const pseudoClassGenerator = n => sampleFromArray(pseudoClasses, n)
const pseudoElementGenerator = () => pseudoElements[Math.floor(Math.random() * pseudoElements.length)]

function generateSelectorSegment(maxSelectors) {
  const numSelectors = Math.ceil(Math.random() * Math.min(6, maxSelectors))
  const selectorParts = []
  if(Math.random() < 0.5) {
    selectorParts.push(tagGenerator())
  }
  if(Math.random() < .1 && selectorParts.length < numSelectors) {
    selectorParts.push(idGenerator())
  }
  const numPseudoClasses = Math.floor(Math.random() * Math.min(3, numSelectors - selectorParts.length))
  const includePseudoElement = (selectorParts.length + numPseudoClasses < numSelectors) && Math.random() < 0.1
  const numClasses = numSelectors - selectorParts.length - numPseudoClasses - (includePseudoElement ? 1 : 0)
  selectorParts.push(...classGenerator(numClasses))
  selectorParts.push(...pseudoClassGenerator(numPseudoClasses))
  if(includePseudoElement) {
    selectorParts.push(pseudoElementGenerator())
  }

  return selectorParts
}

/* Generates a random integer between 1 and the max value. Uses
   a quadratic distribution to give less weight to lower numbers.
 */
function quadraticDistributionRandom(max = 16) {
  const random = Math.random() * max
  return Math.ceil(random * random / max)
}

/**
 * Produces a selector out of up to 16 individual selectors. Includes a random
 * number of combinators.
 *
 * Example return values:
 * * `['textarea', ' + ', 'div']`
 * * `['div', ' > ', '.broccoli', ':hover']`
 * * `['.carrot']`
 * * `['nav', '.broccolini', ':first-child', ' > ', '#pea', '.pea', '.cauliflower', ':nth-child(odd)', ' ~ ', '.broccolini', '.spinach', ':nth-child(odd)', ':active', ' + ', 'span', '.garam-masala', '.cilantro', ':active']`
 *
 * @returns {string[]} An array where each element is a selector or combinator.
 */
export function generateSelector() {
  const selectorParts = []
  const numSelectors = quadraticDistributionRandom()
  for(let numSegments = 0; selectorParts.length < numSelectors; numSegments++) {
    if(numSegments > 0) {
      selectorParts.push(combinators[Math.floor(Math.random() * combinators.length)])
    }
    selectorParts.push(...generateSelectorSegment(numSelectors - (selectorParts.length - numSegments)))
  }
  return selectorParts
}