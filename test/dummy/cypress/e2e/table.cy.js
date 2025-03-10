describe('HDI Table Responsive Display', () => {
  beforeEach(() => {
    cy.visit('/?brand=hdi');
  });

  it('should display a table with headers on large screens', () => {
    cy.viewport(1280, 720); // Set large screen

    cy.get("[data-test='table']").within(() => {
      cy.contains('Table Caption')
        .get('thead').should('be.visible')
        .find('tr th')
        .should('have.length', 4)
        .then(($headers) => {
          expect($headers.eq(0)).to.contain('Name');
          expect($headers.eq(1)).to.contain('Age');
          expect($headers.eq(2)).to.contain('Medication');
          expect($headers.eq(3)).to.contain('How much');
        });

      // Ensure normal row layout
      cy.get('tbody tr').should('have.length.greaterThan', 0);
      cy.get('tbody tr td').should('have.length.greaterThan', 0);
    });
  });

  it('should show stacked data cells on small screens', () => {
    cy.viewport(375, 667); // Set small screen (mobile)

    cy.get("[data-test='table']").within(() => {
      cy.contains('Table Caption')
        .get('thead').should('not.be.visible');

      // Each <td> should contain the column label + value
      cy.get('tbody tr').each(($row) => {
        cy.wrap($row).find('td').each(($cell, index) => {
          cy.wrap($cell).invoke('text').then((text) => {
            const columnLabel = ['Name', 'Age', 'Medication', 'How much'];
            const expectedLabels = ['Name', 'Age', 'Medication', 'How much'];
            const hasLabel = expectedLabels.some(label => text.includes(label));

            expect(hasLabel).to.be.true; // Ensures the label is present in the cell
            expect(text.replace(/Name|Age|Medication|How much/g, '').trim().length).to.be.greaterThan(0); // Ensures there's also a value
          });
        });
      });
    });
  });
});
