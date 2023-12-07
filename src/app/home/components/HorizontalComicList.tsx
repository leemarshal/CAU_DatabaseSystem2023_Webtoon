import ComicItem from "./ComicItem";

export default function HorizontalComicList({
  props,
}: {
  props: {
    comicList: {
      WebtoonID: number;
      Title: string | null;
      ThumbnailURL: string | null;
    }[];
  };
}) {
  return (
    <div
      style={{
        padding: 20,
        overflow: "scroll",
        whiteSpace: "nowrap",
        background: "white",
      }}
    >
      {props.comicList.map((item, index) => (
        <ComicItem
          key={index}
          props={{
            title: item.Title ?? "",
            image: item.ThumbnailURL ?? "",
            path: "/comic?id=" + item.WebtoonID,
            width: "45%",
          }}
        />
      ))}
    </div>
  );
}
