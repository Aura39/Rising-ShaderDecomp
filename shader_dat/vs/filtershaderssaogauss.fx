float4 g_TargetUvParam : register(c194);
float4 g_TexelOffsets0 : register(c184);
float4 g_TexelOffsets1 : register(c185);
float4 g_TexelOffsets2 : register(c186);
float4 g_TexelOffsets3 : register(c187);

struct VS_IN
{
	float4 position : POSITION;
	float4 texcoord : TEXCOORD;
};

struct VS_OUT
{
	float4 position : POSITION;
	float4 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
	float4 texcoord2 : TEXCOORD2;
	float4 texcoord3 : TEXCOORD3;
};

VS_OUT main(VS_IN i)
{
	VS_OUT o;

	float4 r0;
	float2 r1;
	r0 = g_TexelOffsets0 + i.texcoord.xyxy;
	r1.xy = float2(2, 1);
	o.texcoord = g_TargetUvParam.xyxy * r1.xyxy + r0;
	r0 = g_TexelOffsets1 + i.texcoord.xyxy;
	o.texcoord1 = g_TargetUvParam.xyxy * r1.xyxy + r0;
	r0 = g_TexelOffsets2 + i.texcoord.xyxy;
	o.texcoord2 = g_TargetUvParam.xyxy * r1.xyxy + r0;
	r0 = g_TexelOffsets3 + i.texcoord.xyxy;
	o.texcoord3 = g_TargetUvParam.xyxy * r1.xyxy + r0;
	o.position = i.position * float4(2, 2, 1, 1) + float4(1, 1, 0, 0);

	return o;
}
