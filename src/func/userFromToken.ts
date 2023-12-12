"use server";

import { PrismaClient } from "@prisma/client";
import { logout } from "./logout";

export async function userFromToken(token: string) {
  const prisma = new PrismaClient();
  const session = await prisma.userTokens.findFirst({
    where: {
      Token: token,
    },
  });
  if (!session?.UserID) {
    await logout(token);
    return undefined;
  }
  const user = await prisma.users.findFirst({
    where: {
      UserID: session.UserID,
    },
  });
  prisma.$disconnect();
  return user;
}
