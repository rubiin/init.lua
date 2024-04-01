return {
  {
    "chrisgrieser/nvim-early-retirement",
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      minimumBufferNum = 4,
      -- if a buffer has been inactive for this many minutes, close it
      retirementAgeMins = 30,
    },
  },
}
