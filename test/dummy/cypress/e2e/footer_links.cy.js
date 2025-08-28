describe('Footer links', () => {
  it('renders custom footer links with options', () => {
    cy.visit('/');
    cy.get('footer .nhsuk-footer ul.nhsuk-footer__list')
      .contains('a.nhsuk-footer__list-item-link', 'Custom Link')
      .should('have.attr', 'href', '#');
    cy.get('footer .nhsuk-footer ul.nhsuk-footer__list a.nhsuk-footer__list-item-link[target="_blank"]').should('exist');
    cy.get('footer .nhsuk-footer ul.nhsuk-footer__list a.nhsuk-footer__list-item-link[rel="noopener"]').should('exist');
    cy.get('footer .nhsuk-footer ul.nhsuk-footer__list')
      .contains('a.nhsuk-footer__list-item-link', 'Another Link')
      .should('have.attr', 'href', '#');
  });
});
