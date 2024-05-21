describe('Index page', () => {
  it('passes', () => {
    cy.visit('/?brand=govuk')
  })
})
describe('Accept cookies', () => {
  it('passes', () => {
    cy.visit('/?brand=govuk')
    cy.get('button[name="cookies[analytics]"]').contains('Accept').click()
  })
})
