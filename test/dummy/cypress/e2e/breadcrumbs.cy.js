describe('HDI Breadcrumbs Layout', () => {
  beforeEach(() => {
    cy.visit('/?brand=hdi');
  });

  it('should visually truncate the super long breadcrumb', () => {  
    cy.get("[data-test='breadcrumb_item']")
      .contains('A Super Long Breadcrumb Name That Should Be Truncated')
      .should('have.css', 'white-space', 'nowrap')
      .and('have.css', 'overflow', 'hidden')
      .and('have.css', 'text-overflow', 'ellipsis')
      .should(($el) => {
        expect($el[0].scrollWidth).to.be.greaterThan($el[0].clientWidth); // Confirms text overflow
      });
  });  

  it('should display all breadcrumbs on one line when the screen is wide enough', () => {
    cy.viewport(1280, 800); // Simulating a wide screen

    cy.get("[data-test='breadcrumb_list']")
      .invoke('outerHeight')
      .then((initialHeight) => {
        cy.get("[data-test='breadcrumb_list']")
          .invoke('outerHeight')
          .should('equal', initialHeight); // Ensuring height remains unchanged (no wrapping)
      });
  });

  it('should wrap breadcrumbs when the screen width is reduced', () => {
    cy.viewport(600, 800); // Simulating a smaller screen

    cy.get("[data-test='breadcrumb_list']")
      .invoke('outerHeight')
      .then((heightBefore) => {
        cy.get("[data-test='breadcrumb_list']")
          .invoke('css', 'max-width', '400px');
        cy.wait(100);
        cy.get("[data-test='breadcrumb_list']")
          .invoke('outerHeight')
          .should('be.greaterThan', heightBefore); // If wrapped, height increases
      });
  });
});
