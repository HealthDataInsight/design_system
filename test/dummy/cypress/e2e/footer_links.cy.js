describe('Footer links', () => {
  it('renders custom footer links', () => {
    cy.visit('/');
    cy.get('footer .nhsuk-footer ul.nhsuk-footer__list')
      .contains('a.nhsuk-footer__list-item-link', 'Custom Link')
      .should('have.attr', 'href', '#');
    cy.get('footer .nhsuk-footer ul.nhsuk-footer__list')
      .contains('a.nhsuk-footer__list-item-link', 'Another Link')
      .should('have.attr', 'href', '#');
  });
});