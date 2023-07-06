float4 g_Color;
float4 g_ColorAddRate;
float2 g_HalfPixel;
float4 g_TexValidRate;
float2 g_UVOffset;
float4x4 g_ViewProjMatrix;
float4x4 g_WorldMatrix;
float4 g_param;

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
	r0 = i.position.xyzx * float4(1, 1, 1, 0) + float4(0, 0, 0, 1);
	r1.x = dot(r0, transpose(g_WorldMatrix)[0]);
	r1.y = dot(r0, transpose(g_WorldMatrix)[1]);
	r1.z = dot(r0, transpose(g_WorldMatrix)[2]);
	r1.w = dot(r0, transpose(g_WorldMatrix)[3]);
	o.position.w = dot(r1, transpose(g_ViewProjMatrix)[3]);
	r0.x = dot(r1, transpose(g_ViewProjMatrix)[0]);
	r0.y = dot(r1, transpose(g_ViewProjMatrix)[1]);
	o.texcoord1.x = r0.x * 0.5 + 0.5;
	o.position.xy = r0.xy + g_HalfPixel.xy;
	r0.x = r0.y * -0.5 + 0.5;
	o.texcoord1.y = r0.x + -g_HalfPixel.y;
	o.texcoord = g_UVOffset.xy + i.texcoord.xy;
	r0 = g_Color * i.color;
	o.texcoord2 = r0 * g_TexValidRate;
	o.texcoord3 = r0 * g_ColorAddRate;
	o.position.z = 0;
	o.texcoord4 = g_param;

	return o;
}
