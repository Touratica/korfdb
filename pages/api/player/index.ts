import { PrismaClientKnownRequestError } from "@prisma/client/runtime";
import type { NextApiRequest, NextApiResponse } from "next";
import prisma from "../../../lib/prisma";

// POST /api/player
// Required fields in body: agentId, clubInitials, teamDesignation
// Optional fields in body: none
export default async function handle(
  req: NextApiRequest,
  res: NextApiResponse
) {
  const {
    agentId,
    clubInitials,
    teamDesignation,
  }: { agentId: unknown; clubInitials: unknown; teamDesignation: unknown } =
    req.body;

  if (typeof agentId !== "number")
    return res.status(400).json({ message: "agentId must be a number" });

  if (typeof clubInitials !== "string")
    return res.status(400).json({ message: "clubInitials must be a string" });

  if (typeof teamDesignation !== "string")
    return res
      .status(400)
      .json({ message: "teamDesignation must be a string" });

  await prisma.player
    .create({
      data: {
        agent: {
          connect: {
            id: agentId,
          },
        },
        team: {
          connect: {
            designation_clubInitials: {
              designation: teamDesignation,
              clubInitials: clubInitials,
            },
          },
        },
      },
    })
    .then((player) =>
      res
        .status(201) // 201 Created
        .json(player)
    )
    .catch((error) => {
      if (error instanceof PrismaClientKnownRequestError) {
        switch (error.code) {
          case "P2025":
            if ((error.meta.cause as string).includes("No 'Agent' record"))
              return res
                .status(404) // 404 Not Found
                .json({ message: "Agent not found" });

            if ((error.meta.cause as string).includes("No 'Team' record(s)"))
              return res
                .status(404) // 404 Not Found
                .json({ message: "Team not found" });

            throw error;

          case "P2014":
            return res
              .status(409) // 409 Conflict
              .json({ message: "The player already exists" });

          default:
            throw error;
        }
      }
      throw error;
    });
}
