float4 SoftPt_Rate;
float4 ambient_rate;
float3 fog;
float4 prefogcolor_enhance;

struct PS_IN
{
	float4 color : COLOR;
	float4 texcoord1 : TEXCOORD1;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	r0 = float4(-0, -0, -0, -1) + i.color;
	r1.zw = float2(-0, -1);
	r0 = SoftPt_Rate.y * r0 + r1.zzzw;
	r1.w = ambient_rate.w;
	r1 = r0.w * r1.w + -0.01;
	r0 = r0 * ambient_rate;
	clip(r1);
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	r0.w = r0.w * prefogcolor_enhance.w;
	o.w = r0.w;
	o.xyz = i.texcoord1.www * r0.xyz + fog.xyz;

	return o;
}
