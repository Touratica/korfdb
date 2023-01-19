import { PrismaClient, Prisma } from "@prisma/client";

const prisma = new PrismaClient();

const agentData: Prisma.AgentCreateInput[] = [
  {
    name: "John Doe",
    player: {
      create: {
        team: {
          connectOrCreate: {
            where: {
              designation_clubInitials: {
                clubInitials: "FPC",
                designation: "A",
              },
            },
            create: {
              club: {
                connectOrCreate: {
                  where: {
                    initials: "FPC",
                  },
                  create: {
                    initials: "FPC",
                    name: "Federação Portuguesa de Corfebol",
                  },
                },
              },
              designation: "A",
            },
          },
        },
      },
    },
    referee: {
      create: {
        club: {
          connectOrCreate: {
            where: {
              initials: "FPC",
            },
            create: {
              initials: "FPC",
              name: "Federação Portuguesa de Corfebol",
            },
          },
        },
      },
    },
    coach: {
      create: {
        teams: {
          connectOrCreate: [
            {
              where: {
                designation_clubInitials: {
                  clubInitials: "FPC",
                  designation: "A",
                },
              },
              create: {
                club: {
                  connectOrCreate: {
                    where: {
                      initials: "FPC",
                    },
                    create: {
                      initials: "FPC",
                      name: "Federação Portuguesa de Corfebol",
                    },
                  },
                },
                designation: "A",
              },
            },
            {
              where: {
                designation_clubInitials: {
                  clubInitials: "FPC",
                  designation: "B",
                },
              },
              create: {
                club: {
                  connectOrCreate: {
                    where: {
                      initials: "FPC",
                    },
                    create: {
                      initials: "FPC",
                      name: "Federação Portuguesa de Corfebol",
                    },
                  },
                },
                designation: "B",
              },
            },
          ],
        },
      },
    },
    manager: {
      create: {
        clubs: {
          connectOrCreate: {
            where: {
              initials: "FPC",
            },
            create: {
              initials: "FPC",
              name: "Federação Portuguesa de Corfebol",
            },
          },
        },
      },
    },
    official: { create: {} },
    physiotherapist: {
      create: {
        clubs: {
          connectOrCreate: {
            where: {
              initials: "FPC",
            },
            create: {
              initials: "FPC",
              name: "Federação Portuguesa de Corfebol",
            },
          },
        },
      },
    },
    fitnessCoach: {
      create: {
        clubs: {
          connectOrCreate: {
            where: {
              initials: "FPC",
            },
            create: {
              initials: "FPC",
              name: "Federação Portuguesa de Corfebol",
            },
          },
        },
      },
    },
  },
];

async function main() {
  console.log(`Start seeding ...`);
  for (const a of agentData) {
    const agent = await prisma.agent.create({
      data: a,
    });
    console.log(`Creating agent with id: ${agent.id}`);
  }
  console.log(`Seeding finished.`);
}

main()
  .then(async () => {
    await prisma.$disconnect();
  })
  .catch(async (e) => {
    console.error(e);
    await prisma.$disconnect();
    process.exit(1);
  });
