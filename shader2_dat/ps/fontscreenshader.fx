sampler g_Sampler0 : register(s13);
sampler g_Sampler1 : register(s14);
sampler g_Sampler2 : register(s15);

struct PS_IN
{
	float2 texcoord : TEXCOORD;
	float2 texcoord1 : TEXCOORD1;
	float3 texcoord2 : TEXCOORD2;
	float4 color : COLOR;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	r0 = tex2D(g_Sampler1, i.texcoord1);
	r1 = tex2D(g_Sampler0, i.texcoord);
	r0.x = dot(r1.wxw, i.texcoord2.xyz);
	r1.xyz = r1.xyz * i.texcoord2.xxx + i.texcoord2.yyy;
	r1.xyz = r1.xyz + i.texcoord2.zzz;
	r1.xyz = r1.xyz * -i.color.xyz + 1;
	r0.x = r0.x * i.color.w;
	o.w = r0.w * r0.x;
	r0 = tex2D(g_Sampler2, i.texcoord1);
	r0.xyz = -r0.xyz + 1;
	o.xyz = r0.xyz * -r1.xyz + 1;

	return o;
}
