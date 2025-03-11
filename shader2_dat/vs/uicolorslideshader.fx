float2 g_BlueOffset : register(c65);
float4 g_Color : register(c62);
float4 g_ColorAddRate : register(c68);
float2 g_GreenOffset : register(c64);
float2 g_HalfPixel : register(c66);
float2 g_RedOffset : register(c63);
float4 g_TexValidRate : register(c67);
float4x4 g_ViewProjMatrix : register(c54);
float4x4 g_WorldMatrix : register(c58);

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
	float2 texcoord2 : TEXCOORD2;
	float2 texcoord3 : TEXCOORD3;
	float2 texcoord4 : TEXCOORD4;
	float4 texcoord5 : TEXCOORD5;
	float4 texcoord6 : TEXCOORD6;
};

VS_OUT main(VS_IN i)
{
	VS_OUT o;

	float4 r0;
	float r1;
	r0.x = dot(i.position, transpose(g_WorldMatrix)[0]);
	r0.y = dot(i.position, transpose(g_WorldMatrix)[1]);
	r0.z = dot(i.position, transpose(g_WorldMatrix)[2]);
	r0.w = dot(i.position, transpose(g_WorldMatrix)[3]);
	o.position.w = dot(r0, transpose(g_ViewProjMatrix)[3]);
	r1.x = dot(r0, transpose(g_ViewProjMatrix)[0]);
	r0.x = dot(r0, transpose(g_ViewProjMatrix)[1]);
	r0.y = r0.x + g_HalfPixel.y;
	r0.x = r1.x + g_HalfPixel.x;
	o.texcoord4 = r0.xy * float2(0.5, -0.5) + 0.5;
	o.position.xy = r0.xy;
	o.texcoord1 = g_RedOffset.xy + i.texcoord.xy;
	o.texcoord2 = g_GreenOffset.xy + i.texcoord.xy;
	o.texcoord3 = g_BlueOffset.xy + i.texcoord.xy;
	r0 = g_Color * i.color;
	o.texcoord5 = r0 * g_TexValidRate;
	o.texcoord6 = r0 * g_ColorAddRate;
	o.position.z = 0;
	o.texcoord = i.texcoord.xy;

	return o;
}
