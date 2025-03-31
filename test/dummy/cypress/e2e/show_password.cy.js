describe('Show Password', () => {

  it('should toggle password visibility and button text', () => {
    cy.visit('/assistants/new')

    cy.contains('password')
    
    cy.get('[data-ds--show-password-target="password"]')
      .should('have.attr', 'type', 'password')
    
    cy.contains('button', 'Show password')

    cy.contains('button', 'Show password')
      .click()

    cy.get('[data-ds--show-password-target="password"]')
      .should('have.attr', 'type', 'text')
    
    cy.contains('button', 'Hide password')

    cy.contains('button', 'Hide password')
      .click()

    cy.get('[data-ds--show-password-target="password"]')
      .should('have.attr', 'type', 'password')
    
    cy.contains('button', 'Show password')
  })
})
