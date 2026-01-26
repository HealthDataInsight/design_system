describe('Searchbar Visibility', () => {
  it('should not display searchbar by default', () => {
    cy.visit('/')
    
    // Assert searchbar is not present by default
    cy.get('.nhsuk-header__search').should('not.exist')
    cy.get('#content-header').should('not.exist')
  })
  
  it('should not display searchbar by default for Govuk brand', () => {
      cy.visit('/?brand=govuk')
    
      // Assert searchbar is not present by default for Govuk brand
      cy.get('.govuk-header__search').should('not.exist')
      cy.get('.app-site-search').should('not.exist')
  })
})
