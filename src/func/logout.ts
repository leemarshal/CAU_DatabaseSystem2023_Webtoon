"use server";

import { PrismaClient } from "@prisma/client";
import { cookies } from "next/headers";

export async function logout(token: string) {
  const prisma = new PrismaClient();
  if (token) {
    await prisma.userTokens.delete({
      where: {
        Token: token,
      },
    });
    cookies().delete("token");
  }
  prisma.$disconnect();
}
