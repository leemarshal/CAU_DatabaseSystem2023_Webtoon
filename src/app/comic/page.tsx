import ToolBar from "./components/ToolBar";
import React from "react";
import EpisodeItem from "./components/EpisodeItem";
import { PrismaClient } from "@prisma/client";

export default async function Comic({ searchParams }: { searchParams: any }) {
  const TOOLBAR_HEIGHT = 70;

  const title = "웹툰 ID : " + searchParams.id;

  const prisma = new PrismaClient();
  const episodes = await prisma.episodes.findMany({
    where: {
      WebtoonID: Number(searchParams.id),
    },
    orderBy: [{ EpisodeID: "asc" }],
  });

  return (
    <>
      <ToolBar title={title} height={TOOLBAR_HEIGHT} />

      <div style={{ paddingTop: TOOLBAR_HEIGHT, background: "white" }}>
        {episodes.map((item) => (
          <EpisodeItem
            key={item.EpisodeID}
            path={"/episode?id=" + item.EpisodeID}
            height={70}
            title={item.Title}
            thumb={""}
          />
        ))}
      </div>
    </>
  );
}
