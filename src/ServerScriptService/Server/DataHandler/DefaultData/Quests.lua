return {
    ["EXAMPLE"] = {
        ["QUESTREQUIREMENTS"] = false,
        ["TASKS"] = {
            [1] = {
                ["TASK"] = "ELIMINATE",
                ["DESCRIPTION"] = "Eliminate %s <font color=\"rgb(255, 0, 0)\">%s</font>",
                ["REQUIREMENTS"] = {
                    [1] = {
                        ["NAME"] = "PLAYERS",
                        ["AMOUNT"] = 5
                    }
                },
                ["COMPLETED"] = false
            },
            [2] = {
                ["TASK"] = "OBTAIN",
                ["DESCRIPTION"] = "Obtain %s <font color=\"rgb(255, 0, 0)\">%s</font>",
                ["REQUIREMENTS"] = {
                    [1] = {
                        ["NAME"] = "MONEY",
                        ["AMOUNT"] = 100
                    }
                },
                ["COMPLETED"] = false
            },
            [3] = {
                ["TASK"] = "REACH",
                ["DESCRIPTION"] = "Return back to <font color=\"rgb(255, 0, 0)\">%s</font>",
                ["REQUIREMENTS"] = {
                    [1] = {
                        ["NAME"] = "SPAWN",
                        ["AMOUNT"] = false
                    }
                },
                ["COMPLETED"] = false
            },
        },
        ["REWARDS"] = {
            ["Money"] = 100,
        },
        ["COMPLETED"] = false,
        ["UNLOCKED"] = true,
        ["REWARDS_GIVEN"] = false,
        ["ACTIVE"] = true,
        ["LAYOUTORDER"] = 1
    },
    ["EXAMPLE2"] = {
        ["QUESTREQUIREMENTS"] = false,
        ["TASKS"] = {
            [1] = {
                ["TASK"] = "ELIMINATE",
                ["DESCRIPTION"] = "Eliminate %s <font color=\"rgb(255, 0, 0)\">%s</font>",
                ["REQUIREMENTS"] = {
                    [1] = {
                        ["NAME"] = "PLAYERS",
                        ["AMOUNT"] = 5
                    }
                },
                ["COMPLETED"] = false
            },
            [2] = {
                ["TASK"] = "OBTAIN",
                ["DESCRIPTION"] = "Obtain %s <font color=\"rgb(255, 0, 0)\">%s</font>",
                ["REQUIREMENTS"] = {
                    [1] = {
                        ["NAME"] = "MONEY",
                        ["AMOUNT"] = 100
                    }
                },
                ["COMPLETED"] = false
            },
            [3] = {
                ["TASK"] = "REACH",
                ["DESCRIPTION"] = "Return back to <font color=\"rgb(255, 0, 0)\">%s</font>",
                ["REQUIREMENTS"] = {
                    [1] = {
                        ["NAME"] = "SPAWN",
                        ["AMOUNT"] = false
                    }
                },
                ["COMPLETED"] = false
            },
        },
        ["REWARDS"] = {
            ["Money"] = 100,
        },
        ["COMPLETED"] = false,
        ["UNLOCKED"] = true,
        ["REWARDS_GIVEN"] = false,
        ["ACTIVE"] = true,
        ["LAYOUTORDER"] = 2
    },
    ["EXAMPLE3"] = {
        ["QUESTREQUIREMENTS"] = {
            [1] = "EXAMPLE",
            [2] = "EXAMPLE2"
        },
        ["TASKS"] = {
            [1] = {
                ["TASK"] = "ELIMINATE",
                ["DESCRIPTION"] = "Eliminate %s <font color=\"rgb(255, 0, 0)\">%s</font>",
                ["REQUIREMENTS"] = {
                    [1] = {
                        ["NAME"] = "ZOMBIES",
                        ["AMOUNT"] = 5
                    }
                },
                ["COMPLETED"] = false
            },
            [2] = {
                ["TASK"] = "OBTAIN",
                ["DESCRIPTION"] = "Obtain %s <font color=\"rgb(255, 0, 0)\">%s</font>",
                ["REQUIREMENTS"] = {
                    [1] = {
                        ["NAME"] = "GEMS",
                        ["AMOUNT"] = 100
                    }
                },
                ["COMPLETED"] = false
            },
            [3] = {
                ["TASK"] = "REACH",
                ["DESCRIPTION"] = "Return back to <font color=\"rgb(255, 0, 0)\">%s</font>",
                ["REQUIREMENTS"] = {
                    [1] = {
                        ["NAME"] = "VENDOR",
                        ["AMOUNT"] = false
                    }
                },
                ["COMPLETED"] = false
            },
        },
        ["REWARDS"] = {
            ["Money"] = 100,
        },
        ["COMPLETED"] = false,
        ["UNLOCKED"] = false,
        ["REWARDS_GIVEN"] = false,
        ["ACTIVE"] = false,
        ["LAYOUTORDER"] = 3
    }
}