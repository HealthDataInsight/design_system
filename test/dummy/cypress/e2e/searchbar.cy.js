describe('Searchbar Visibility', () => {
  it('should not display searchbar by default', () => {
    cy.visit('/')
    
    // Assert searchbar is not present by default
    cy.get('.nhsuk-header__search').should('not.exist')
    cy.get('#content-header').should('not.exist')
  })
})