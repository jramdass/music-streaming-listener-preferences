describe('The landing page', () => {
  it('successfully loads', () => {
    cy.visit('/')

    cy.contains('Music Streaming Listener Preferences')
  })
})