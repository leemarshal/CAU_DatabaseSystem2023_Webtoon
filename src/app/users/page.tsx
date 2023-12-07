import { Prisma, PrismaClient } from "@prisma/client";
import { useState } from "react";

const prisma = new PrismaClient();

export default async function Authors() {
  const users = await prisma.users.findMany();

  return (
    <main>
      {users.map((user) => {
        return (
          <div key={user.UserID}>
            <span>id:{user.UserID}</span> <span>name:{user.Username}</span>{" "}
            <span>email:{user.Email}</span>
          </div>
        );
      })}
    </main>
  );
}
