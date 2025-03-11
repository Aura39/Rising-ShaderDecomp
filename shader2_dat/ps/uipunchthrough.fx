sampler g_sampler0 : register(s13);
sampler g_sampler1 : register(s14);

struct PS_IN
{
	float2 texcoord : TEXCOORD;
	float2 texcoord1 : TEXCOORD1;
	float2 texcoord2 : TEXCOORD2;
	float4 color : COLOR;
	float3 color1 : COLOR1;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	r0 = tex2D(g_sampler1, i.texcoord1);
	r0.xy = r0.ww + -i.texcoord2.xy;
	r0.z = (r0.y >= 0) ? -1 : -0;
	r0.x = (r0.x >= 0) ? -0 : r0.z;
	r1 = tex2D(g_sampler0, i.texcoord);
	r1 = r1 * i.color;
	o.xyz = (r0.xxx >= 0) ? r1.xyz : i.color1.xyz;
	o.w = (r0.y >= 0) ? r1.w : 0;

	return o;
}
