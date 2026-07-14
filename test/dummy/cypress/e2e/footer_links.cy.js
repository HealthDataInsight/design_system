describe('Footer links', () => {
  it('renders custom footer links with options', () => {
    cy.visit('/');
    cy.get('footer.nhsuk-footer ul.nhsuk-footer__list')
      .contains('a.nhsuk-footer__list-item-link', 'Download the RubyGem')
      .should('have.attr', 'href', 'https://rubygems.org/gems/design_system');
    cy.get('footer.nhsuk-footer ul.nhsuk-footer__list a.nhsuk-footer__list-item-link[target="_blank"]').should('exist');
    cy.get('footer.nhsuk-footer ul.nhsuk-footer__list a.nhsuk-footer__list-item-link[rel="noopener"]').should('exist');
    cy.get('footer.nhsuk-footer ul.nhsuk-footer__list')
      .contains('a.nhsuk-footer__list-item-link', 'View the source on GitHub')
      .should('have.attr', 'href', 'https://github.com/HealthDataInsight/design_system');
    cy.get('footer.nhsuk-footer ul.nhsuk-footer__list')
      .contains('a.nhsuk-footer__list-item-link', 'Get in touch')
      .should('have.attr', 'href', 'https://github.com/HealthDataInsight/design_system/issues');
  });

  it('renders the copyright notice', () => {
    cy.visit('/');
    cy.get('footer.nhsuk-footer .nhsuk-footer__meta p')
      .should('contain.text', '© Health Data Insight CIC 2026');
  });

  it('hides the Crown emblem, OGL licence and copyright crest on the GOV.UK footer', () => {
    cy.visit('/?brand=govuk');
    cy.get('footer.govuk-footer').should('exist');
    cy.get('footer.govuk-footer .govuk-footer__crown').should('not.exist');
    cy.get('footer.govuk-footer .govuk-footer__licence-logo').should('not.exist');
    cy.get('footer.govuk-footer .govuk-footer__copyright-logo').should('not.exist');
    cy.get('footer.govuk-footer .govuk-footer__meta-custom')
      .should('contain.text', '© Health Data Insight CIC 2026');
  });
});
