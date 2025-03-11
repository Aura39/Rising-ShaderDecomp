float4 g_Color : register(c218);
float4 g_ColorAddRate : register(c222);
float2 g_HalfPixel : register(c220);
float4 g_TexValidRate : register(c221);
float2 g_UVOffset : register(c219);
float4x4 g_ViewProjMatrix : register(c54);
float4x3 g_WorldMatrix : register(c58);
float g_ZSortOffset : register(c224);
float4 g_param : register(c223);

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
	float4 texcoord4 : TEXCOORD4;
};

VS_OUT main(VS_IN i)
{
	VS_OUT o;

	float4 r0;
	float4 r1;
	r0.x = frac(i.position.w);
	r0.x = -r0.x + i.position.w;
	r0.x = r0.x * 3;
	color.x = r0.x;
	r0 = i.position.xyzx * float4(1, 1, 1, 0) + float4(0, 0, 0, 1);
	r1.x = dot(r0, transpose(g_WorldMatrix)[0][i]);
	r1.y = dot(r0, transpose(g_WorldMatrix)[1][i]);
	r1.z = dot(r0, transpose(g_WorldMatrix)[2][i]);
	r1.w = 1;
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
	o.texcoord4 = g_param;

	return o;
}
