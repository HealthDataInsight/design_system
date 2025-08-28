describe('Assistants Index Page', () => {
  it('passes', () => {
    cy.visit('/assistants?brand=nhsuk')
  })
})
describe('New Assistant Form', () => {
  it('creates a new assistant with all required fields', () => {
    cy.visit('/assistants/new?brand=nhsuk')
    cy.get('form[action="/assistants"]').within(() => {
      cy.get('input[name="assistant[title]"]').first().type('Mr')
      cy.get('input[name="assistant[age]"]').type('30')
      cy.get('input[name="assistant[colour]"][value="red"]').check()
      cy.get('textarea[name="assistant[description]"]').type('A helpful assistant')
      cy.get('input[name="assistant[lunch_option]"][value="Salad"]').check()
      cy.get('input[name="assistant[password]"]').type('supersecurepassword')
      cy.get('input[name="assistant[terms_agreed]"]').check()
      cy.get('input[name="assistant[website]"]').type('https://example.com')
      cy.get('select[name="assistant[department_id]"]').select('Finance')
      cy.get('select[name="assistant[role_id]"]').select('User')
      cy.get('input[name="assistant[desired_filling][]"][value="pastrami"]').check()
      cy.get('input[name="assistant[date_of_birth(3i)]"]').type('01') // Day
      cy.get('input[name="assistant[date_of_birth(2i)]"]').type('01') // Month
      cy.get('input[name="assistant[date_of_birth(1i)]"]').type('1990') // Year
      cy.get('input[name="assistant[email]"]').type('test@example.com')
      cy.contains('Continue').first().click()
    })
    cy.contains('Assistant was successfully created')
  })
})
