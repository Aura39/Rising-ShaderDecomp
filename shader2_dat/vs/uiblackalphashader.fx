float4 g_Color : register(c62);
float4 g_ColorAddRate : register(c66);
float2 g_HalfPixel : register(c64);
float4 g_TexValidRate : register(c65);
float2 g_UVOffset : register(c63);
float4x4 g_ViewProjMatrix : register(c54);
float4x4 g_WorldMatrix : register(c58);
float g_ZSortOffset : register(c68);

struct VS_IN
{
	float4 position : POSITION;
	float4 texcoord : TEXCOORD;
	float4 color : COLOR;
};

struct VS_OUT
{
	float4 position : POSITION;
	float2 texcoord : TEXCOORD;
	float2 texcoord1 : TEXCOORD1;
	float4 texcoord2 : TEXCOORD2;
	float4 texcoord3 : TEXCOORD3;
};

VS_OUT main(VS_IN i)
{
	VS_OUT o;

	float4 r0;
	float4 r1;
	r0 = i.position.xyzx * float4(1, 1, 1, 0) + float4(0, 0, 0, 1);
	r1.x = dot(r0, transpose(g_WorldMatrix)[0]);
	r1.y = dot(r0, transpose(g_WorldMatrix)[1]);
	r1.z = dot(r0, transpose(g_WorldMatrix)[2]);
	r1.w = dot(r0, transpose(g_WorldMatrix)[3]);
	o.position.w = dot(r1, transpose(g_ViewProjMatrix)[3]);
	r0.x = dot(r1, transpose(g_ViewProjMatrix)[2]);
	o.position.z = r0.x * g_ZSortOffset.x;
	r0.x = dot(r1, transpose(g_ViewProjMatrix)[0]);
	r0.y = dot(r1, transpose(g_ViewProjMatrix)[1]);
	r1.xy = r0.xy + g_HalfPixel.xy;
	o.texcoord1 = r1.xy * float2(0.5, -0.5) + 0.5;
	o.position.xy = r1.xy;
	o.texcoord = g_UVOffset.xy + i.texcoord.xy;
	r0 = g_Color * i.color;
	o.texcoord2 = r0 * g_TexValidRate;
	o.texcoord3 = r0 * g_ColorAddRate;

	return o;
}
