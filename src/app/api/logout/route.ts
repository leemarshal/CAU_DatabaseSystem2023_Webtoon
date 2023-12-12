import { logout } from "@/func/logout";
import { PrismaClient } from "@prisma/client";
import { cookies } from "next/headers";
import { NextRequest, NextResponse } from "next/server";

export async function POST(request: NextRequest) {
  const token = cookies().get("token")?.value;
  if (token) {
    await logout(token);
  }
  return NextResponse.redirect(new URL("/", request.url));
}
