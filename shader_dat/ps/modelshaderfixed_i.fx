float4 g_MatrialColor : register(c192);
sampler g_Sampler0 : register(s0);

struct PS_IN
{
	float2 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
	float4 texcoord2 : TEXCOORD2;
	float4 texcoord3 : TEXCOORD3;
};

struct PS_OUT
{
	float4 color2 : COLOR2;
	float4 color : COLOR;
	float4 color1 : COLOR1;
	float4 color3 : COLOR3;
};

PS_OUT main(PS_IN i)
{
	PS_OUT o;

	float4 r0;
	r0.w = g_MatrialColor.w;
	r0 = r0.w + 10;
	clip(r0);
	r0.xyz = g_MatrialColor.xyz * i.texcoord1.xyz;
	o.color2.xyz = r0.xyz + r0.xyz;
	r0 = tex2D(g_Sampler0, i.texcoord);
	o.color.xyz = r0.xyz;
	o.color.w = 1;
	o.color1 = i.texcoord2;
	o.color2.w = i.texcoord1.w;
	o.color3 = i.texcoord3;

	return o;
}
