describe 'Array', ->
  describe '#indexOf()', ->
    it 'should return -1 when not present', ->
      [1,2,3].indexOf(4).should.equal -1