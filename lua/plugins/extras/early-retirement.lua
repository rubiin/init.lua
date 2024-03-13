return {
  {
    "chrisgrieser/nvim-early-retirement",
    event = "VeryLazy",
    lazy = true,
    opts = {
      minimumBufferNum = 4,
      -- if a buffer has been inactive for this many minutes, close it
      retirementAgeMins = 30,
    },
  },
}
