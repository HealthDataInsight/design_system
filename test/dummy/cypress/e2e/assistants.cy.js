describe('Assistants Index Page', () => {
  it('passes', () => {
    cy.visit('/assistants?brand=nhsuk')
  })
})
describe('New Assistant Form', () => {
  it('passes', () => {
    cy.visit('/assistants/new?brand=nhsuk')
    cy.get('form[action="/assistants"]').within(() => {
      cy.get('input[type=text]').first().type('Titus Groan')
      cy.get('select').last().select('Finance')
      cy.get('input[type=checkbox]').each(($el, index, $list) => {
        $el.click()
      })
      cy.contains('Continue').first().click()
    })
    cy.contains('Assistant was successfully created')
    cy.contains('Titus Groan')
  })
})
